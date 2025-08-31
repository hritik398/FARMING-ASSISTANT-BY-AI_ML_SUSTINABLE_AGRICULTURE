import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth_service.dart';
import '../services/iot_service.dart';
import '../services/disease_model.dart';
import '../services/firestore_service.dart';
import '../routes.dart';
import '../widgets/sensor_tile.dart';
class DashboardScreen extends StatefulWidget {
const DashboardScreen({super.key});
@override
State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
final _deviceIdCtrl = TextEditingController(text: 'demo-device-001');
Map<String, dynamic>? _lastDetection;
bool _busy = false;
@override
void initState() {
super.initState();
DiseaseModel.load();
}
Future<void> _pickAndDetect(ImageSource source) async {
setState(() => _busy = true);
try {
final picker = ImagePicker();
final x = await picker.pickImage(source: source, imageQuality: 92);
if (x == null) return;
final file = File(x.path);
final result = await DiseaseModel.runOnImage(file);
setState(() => _lastDetection = result);
final user = context.read<AuthService>().currentUser!;
// In a real app, upload image to Firebase Storage and get URL
await FirestoreService.saveDiseaseRecord(
uid: user.uid,
label: result['label'] as String,
confidence: (result['confidence'] as num).toDouble(),
imageUrl: 'local://${x.name}',
at: 
  if (mounted) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Detected: ${result['label']} ($
{((result['confidence'] as double) * 100).toStringAsFixed(1)}%)')),
);
}
} catch (e) {
if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
Text('Detection failed: $e')));
} finally {
if (mounted) setState(() => _busy = false);
}
}
@override
Widget build(BuildContext context) {
final user = context.watch<AuthService>().currentUser;
return Scaffold(
appBar: AppBar(
title: const Text('Farming Assistant'),
actions: [
IconButton(
icon: const Icon(Icons.logout),
onPressed: () async {
await context.read<AuthService>().signOut();
if (mounted) Navigator.pushNamedAndRemoveUntil(context,
AppRoutes.login, (_) => false);
},
  ),
],
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
Text('Hello, ${user?.email ?? 'Farmer'}', style:
Theme.of(context).textTheme.titleMedium),
const SizedBox(height: 12),
// Device selector
TextField(
controller: _deviceIdCtrl,
decoration: const InputDecoration(
labelText: 'IoT Device ID',
prefixIcon: Icon(Icons.sensors),
border: OutlineInputBorder(),
),
),
const SizedBox(height: 12),
// Sensor stream card
Card(
child: Padding(
padding: const EdgeInsets.all(12),
child: StreamBuilder(
stream: IotService.sensorStream(_deviceIdCtrl.text),
builder: (context, snapshot) {
if (!snapshot.hasData) {
  return const Center(child: Padding(padding:
EdgeInsets.all(12), child: Text('Waiting for sensor data…')));
}
final event = snapshot.data!;
if (event.snapshot.value == null) {
return const Text('No readings yet for this device.');
}
final map = Map<String, dynamic>.from(
(event.snapshot.children.isNotEmpty ?
event.snapshot.children.first.value : event.snapshot.value)
as Map<dynamic, dynamic>);
final temp = (map['temperature'] ?? 0).toString();
final hum = (map['humidity'] ?? 0).toString();
final moist = (map['moisture'] ?? 0).toString();
return Row(
children: [
Expanded(child: SensorTile(icon: Icons.thermostat, label:
'Temp', value: '$temp °C')),
Expanded(child: SensorTile(icon: Icons.water_drop, label:
'Humidity', value: '$hum %')),
Expanded(child: SensorTile(icon: Icons.grass, label:
'Moisture', value: moist)),
],
);
},
),
),
),
const SizedBox(height: 16),
// Detection buttons
Row(
children: [
Expanded(
child: FilledButton.icon(
onPressed: _busy ? null : () =>
  _pickAndDetect(ImageSource.camera),
icon: const Icon(Icons.camera_alt),
label: const Text('Scan Leaf (Camera)'),
),
),
const SizedBox(width: 12),
Expanded(
child: OutlinedButton.icon(
onPressed: _busy ? null : () =>
_pickAndDetect(ImageSource.gallery),
icon: const Icon(Icons.photo_library),
label: const Text('Upload from Gallery'),
),
),
],
),
const SizedBox(height: 16),
if (_lastDetection != null)
Card(
child: ListTile(
leading: const Icon(Icons.biotech),
title: Text('Prediction: ${_lastDetection!['label']}'),
subtitle: Text('Confidence: ${((_lastDetection!['confidence']
as double) * 100).toStringAsFixed(1)}%'),
),
),
],
),
);
}
}

