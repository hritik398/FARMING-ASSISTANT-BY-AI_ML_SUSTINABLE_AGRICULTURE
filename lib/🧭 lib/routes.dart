import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/capture_screen.dart';


class AppRoutes {
static const splash = '/';
static const login = '/login';
static const register = '/register';
static const dashboard = '/dashboard';
static const capture = '/capture';


static Map<String, WidgetBuilder> routes = {
splash: (_) => const SplashScreen(),
login: (_) => const LoginScreen(),
register: (_) => const RegisterScreen(),
dashboard: (_) => const DashboardScreen(),
capture: (_) => const CaptureScreen(),
};
}
