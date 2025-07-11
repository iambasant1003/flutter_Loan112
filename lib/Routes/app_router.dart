import 'package:go_router/go_router.dart';
import 'package:loan112_app/Screens/auth/login_page.dart';
import 'package:loan112_app/Screens/auth/verify_otp.dart';
import 'package:loan112_app/Screens/dashboard/dashboard_page.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/bankStatement/bank_statement.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/bankStatement/onlinebankStatement/online_bank_statement.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/bankStatement/onlinebankStatement/online_banking_message.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/checkEligibility/check_eligibility.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/checkEligibility/eligibility_status.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loan_application_page.dart';
import '../Screens/auth/permission_page.dart';
import '../Screens/auth/splash.dart';
import '../Screens/loanApplicationPage/loanApplicationOptions/bankStatement/offlineBankStatement/offline_bank_statement.dart';
import '../Screens/loanApplicationPage/loanApplicationOptions/eKyc/aadhar_ekyc.dart';
import '../Screens/loanApplicationPage/loanApplicationOptions/eKyc/ekyc_message.dart';
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
    GoRoute(path: AppRouterName.loanApplicationPage,builder: (context,state)=> LoanApplicationPage()),
    GoRoute(path: AppRouterName.checkEligibilityPage,builder: (context,state)=> CheckEligibility()),
    GoRoute(path: AppRouterName.eligibilityStatus,builder: (context,state)=> EligibilityStatus()),
    GoRoute(path: AppRouterName.bankStatement,builder: (context,state)=> BankStatementScreen()),
    GoRoute(path: AppRouterName.onlineBankStatement,builder: (context,state)=> OnlineBankingOption()),
    GoRoute(path: AppRouterName.onlineBankStatementMessage,builder: (context,state)=> OnlineBankingMessageScreen()),
    GoRoute(path: AppRouterName.aaDarKYCScreen,builder: (context,state)=> AadharKycScreen()),
    GoRoute(path: AppRouterName.eKycMessageScreen,builder: (context,state) => EkycMessageScreen()),
    GoRoute(path: AppRouterName.offlineBankStatement,builder: (context,state) => FetchOfflineBankStatement())
  ],
);
