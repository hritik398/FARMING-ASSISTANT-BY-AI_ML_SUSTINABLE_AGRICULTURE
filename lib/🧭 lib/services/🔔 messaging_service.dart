import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class MessagingService {
static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}


static Future<void> initialize() async {
final messaging = FirebaseMessaging.instance;


if (Platform.isIOS) {
await messaging.requestPermission(alert: true, badge: true, sound: true);
}


FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


FirebaseMessaging.onMessage.listen((message) {
debugPrint('Foreground message: \'${message.notification?.title}\'');
});


final token = await messaging.getToken();
debugPrint('FCM token: $token');
}
}
