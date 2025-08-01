
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Constant/ColorConst/ColorConstant.dart';
import 'di/di_locator.dart';
import 'main.dart';


Future<void> mainCommon(String env) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


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
