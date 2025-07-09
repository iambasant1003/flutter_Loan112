import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Model/VerifyOTPModel.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import '../../Routes/app_router_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Call async logic after the widget is initialized

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Or any other color
        statusBarIconBrightness: Brightness.light, // or Brightness.dark
      ),
    );

    Future.delayed(Duration.zero, () {
      _initAsync(context);
    });
  }

  Future<void> _initAsync(BuildContext context) async {
    var isPermissionGiven = await MySharedPreferences.getPermissionStatus();
    var dashBoardData = await MySharedPreferences.getUserSessionData();
    DebugPrint.prt("Is permission Given $isPermissionGiven");
    DebugPrint.prt("Dashbaord Data ${dashBoardData.runtimeType}");
    Future.delayed(const Duration(seconds: 3), ()  {
      if(dashBoardData != "" && dashBoardData != null){
        VerifyOTPModel verifyOTPModel = VerifyOTPModel.fromJson(jsonDecode(dashBoardData));
        if(verifyOTPModel.data?.token != "" && verifyOTPModel.data?.token != null){
          GoRouter.of(context).push(AppRouterName.dashboardPage);
        }
        else{
          if(isPermissionGiven){
            GoRouter.of(context).go(AppRouterName.login);
          }else{
            GoRouter.of(context).go(AppRouterName.permissionPage);
          }
        }
      } else{
        if(isPermissionGiven){
          context.go(AppRouterName.login);
        }else{
          context.go(AppRouterName.permissionPage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.splashScreenPath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );

  }
}
