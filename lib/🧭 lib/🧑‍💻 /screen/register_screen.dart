import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes.dart';
import '../services/auth_service.dart';
class RegisterScreen extends StatefulWidget {
const RegisterScreen({super.key});
@override
State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
final _email = TextEditingController();
final _password = TextEditingController();
bool _loading = false;
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Register')),
body: Padding(
padding: const EdgeInsets.all(16),
child: Column(children: [
TextField(controller: _email, decoration: const
InputDecoration(labelText: 'Email')),
const SizedBox(height: 8),
TextField(controller: _password, decoration: const
          InputDecoration(labelText: 'Password'), obscureText: true),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: FilledButton(
onPressed: _loading ? null : () async {
setState(() => _loading = true);
try {
await
context.read<AuthService>().registerWithEmail(_email.text.trim(),
_password.text.trim());
if (mounted) Navigator.pushReplacementNamed(context,
AppRoutes.dashboard);
} catch (e) {
if (mounted)
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
Text(e.toString())));
} finally {
if (mounted) setState(() => _loading = false);
}
},
child: _loading ? const CircularProgressIndicator() : const
Text('Create'),
),
),
]),
),
);
}
}
