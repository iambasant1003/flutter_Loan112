
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'Constant/ColorConst/ColorConstant.dart';
import 'di/di_locator.dart';
import 'main.dart';


// Handle messages in background
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  DebugPrint.prt('🔕 Handling a background message: ${message.messageId}');
}


Future<void> mainCommon(String env) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Enable Crashlytics in debug mode for testing
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Catch uncaught errors
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // setup DI
  setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: ColorConstant.appThemeColor));
  runApp(MyApp(environment: env));
}

