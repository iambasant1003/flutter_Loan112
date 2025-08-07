import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static String? fcmToken;

  /// Call this once during app startup (e.g. in SplashScreen or main)
   Future<void> init(BuildContext context) async {
    // Request notification permissions
    await _requestPermissions();

    // Get FCM token
    fcmToken = await _messaging.getToken();
    DebugPrint.prt("📲 FCM Token: $fcmToken");
    if(fcmToken != null){
      MySharedPreferences.setNotificationToken(fcmToken ?? "");
    }

    // Initialize local notifications
    await _initializeLocalNotifications(context);

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Background → foreground via notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(context, message.data);
    });

    // Terminated → app opened via notification
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(context, initialMessage.data);
    }
  }

  static Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied ||
          await Permission.notification.isPermanentlyDenied) {
        final status = await Permission.notification.request();
        DebugPrint.prt("🔔 Android Notification Permission: $status");
      }
    }
  }

  static Future<void> _initializeLocalNotifications(BuildContext context) async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInit = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (context.mounted) {
          _handleNotificationTap(context, _parsePayload(response.payload));
        }
      },
    );

    // Create notification channel (required for Android 8+)
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'App Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;

    if (notification != null && Platform.isAndroid) {
      DebugPrint.prt("📩 Foreground Notification: ${notification.title}");

      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'App Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const notifDetails = NotificationDetails(android: androidDetails);

      await _localNotifications.show(
        0,
        notification.title,
        notification.body,
        notifDetails,
        payload: data.toString(),
      );
    }
  }

  static void _handleNotificationTap(BuildContext context, Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) return;

    final type = data['type'];
    final id = data['id'];

    DebugPrint.prt("🔁 Notification Tapped: type=$type, id=$id");

    if (type == 'loan' && id != null) {
      Navigator.pushNamed(context, '/loanDetails', arguments: id);
    } else if (type == 'offer') {
      Navigator.pushNamed(context, '/offers');
    } else {
      Navigator.pushNamed(context, '/notifications');
    }
  }

  /// Utility to convert payload string → Map<String, String>
  static Map<String, String>? _parsePayload(String? payload) {
    if (payload == null || payload.isEmpty) return null;

    try {
      final cleaned = payload.replaceAll(RegExp(r'[{}]'), '');
      final parts = cleaned.split(',').map((e) => e.trim().split(':'));
      return {
        for (final pair in parts)
          if (pair.length == 2)
            pair[0].trim(): pair[1].trim(),
      };
    } catch (e) {
      DebugPrint.prt("❌ Payload parsing error: $e");
      return null;
    }
  }
}


