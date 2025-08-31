import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes.dart';
import '../services/auth_service.dart';


class SplashScreen extends StatelessWidget {
const SplashScreen({super.key});


@override
Widget build(BuildContext context) {
return StreamBuilder<User?>(
stream: context.read<AuthService>().authChanges(),
builder: (_, snap) {
if (snap.connectionState == ConnectionState.waiting) {
return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
Future.microtask(() {
if (snap.data == null) {
Navigator.pushReplacementNamed(context, AppRoutes.login);
} else {
Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
}
});
return const Scaffold(body: SizedBox.shrink());
},
);
}
}
