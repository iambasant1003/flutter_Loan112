import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Constant/ColorConst/ColorConstant.dart';
import 'di/di_locator.dart';
import 'main.dart';


Future<void> mainCommon(String env) async{
  WidgetsFlutterBinding.ensureInitialized();

  // setup DI
  setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: ColorConstant.appThemeColor));
  runApp(MyApp(environment: env));
}
