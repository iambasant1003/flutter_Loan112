


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loan112_app/BlocProvider/app_repository_provider.dart';
import 'package:loan112_app/BlocProvider/bloc_provider.dart';
import 'Constant/ColorConst/ColorConstant.dart';
import 'Constant/ConstText/ConstText.dart';
import 'Routes/app_router.dart';
import 'Utils/AppConfig.dart';


class MyApp extends StatefulWidget {

  final String environment;

  const MyApp({super.key, required this.environment});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Initialize your config class
    AppConfig.init(widget.environment);
    configLoading();
  }




  @override
  Widget build(BuildContext context) {
     return MultiRepositoryProvider(
       providers: appRepositoryProviders,
       child: MultiBlocProvider(
         providers: appBlocProviders,
         child: ScreenUtilInit(
           designSize: const Size(414, 896),
           minTextAdapt: true,
           splitScreenMode: true,
           builder: (context, child) {
             return MaterialApp.router(
               debugShowCheckedModeBanner: false,
               title: ConstText.appName,
               theme: ThemeData(
                 useMaterial3: false,
                 fontFamily: ConstText.fontType,
                 primaryColor: ColorConstant.appThemeColor,
                 scaffoldBackgroundColor: ColorConstant.whiteColor,
                 appBarTheme: AppBarTheme(
                   systemOverlayStyle: SystemUiOverlayStyle(
                     statusBarColor: ColorConstant.appThemeColor,
                   ),
                 ),
               ),
               routerConfig: appRouter,
               builder: EasyLoading.init(),
             );
           },
         ),
       ),
     );
  }




  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.orange
      ..backgroundColor = Colors.grey[100]
      ..indicatorColor = ColorConstant.appThemeColor
      ..textColor = Colors.grey
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
    //..customAnimation = CustomAnimation();
  }

}
