import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'services/auth_service.dart';
import 'services/messaging_service.dart';


class FarmingAssistantApp extends StatefulWidget {
const FarmingAssistantApp({super.key});


@override
State<FarmingAssistantApp> createState() => _FarmingAssistantAppState();
}


class _FarmingAssistantAppState extends State<FarmingAssistantApp> {
@override
void initState() {
super.initState();
MessagingService.initialize();
}


@override
Widget build(BuildContext context) {
return MultiProvider(
providers: [
ChangeNotifierProvider(create: (_) => AuthService()),
],
child: MaterialApp(
title: 'Farming Assistant',
theme: ThemeData(
useMaterial3: true,
colorSchemeSeed: Colors.green,
brightness: Brightness.light,
),
initialRoute: AppRoutes.splash,
routes: AppRoutes.routes,
debugShowCheckedModeBanner: false,
),
);
}
}
