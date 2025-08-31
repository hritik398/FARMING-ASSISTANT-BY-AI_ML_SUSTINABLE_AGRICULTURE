import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(children: [
        TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
        TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.text, password: pass.text,
            );
            if (context.mounted) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
            }
          },
          child: const Text("Sign In"),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
          child: const Text("Create Account"),
        )
      ]),
    );
  }
}
