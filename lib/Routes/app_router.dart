import 'package:go_router/go_router.dart';
import 'package:loan112_app/Screens/auth/login_page.dart';
import 'package:loan112_app/Screens/auth/verify_otp.dart';
import 'package:loan112_app/Screens/dashboard/dashboard_page.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loan_application_page.dart';
import '../Screens/auth/permission_page.dart';
import '../Screens/auth/splash.dart';
import 'app_router_name.dart';


final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: AppRouterName.login, builder: (context, state) => LogInPage()),
    GoRoute(path: AppRouterName.permissionPage, builder: (context, state) => PermissionPage()),
    GoRoute(path: AppRouterName.verifyOtp,builder:(context,state){
      final phone = state.extra as String;
      return VerifyOTP(mobileNumber: phone);
    }),
    GoRoute(path: AppRouterName.dashboardPage,builder: (context,state)=> DashBoardPage()),
    GoRoute(path: AppRouterName.loanApplicationPage,builder: (context,state)=> LoanApplicationPage())
  ],
);
