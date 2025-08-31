import 'package:flutter/material.dart';
class SensorTile extends StatelessWidget {
final IconData icon;
final String label;
final String value;
const SensorTile({super.key, required this.icon, required this.label,
required this.value});
@override
Widget build(BuildContext context) {
return Column(
children: [
Icon(icon),
const SizedBox(height: 8),
Text(label, style: Theme.of(context).textTheme.labelMedium),
const SizedBox(height: 4),
Text(value, style: Theme.of(context).textTheme.titleMedium),
],
);
}
}
