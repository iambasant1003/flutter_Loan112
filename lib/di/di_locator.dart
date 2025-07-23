import 'package:get_it/get_it.dart';
import 'package:loan112_app/Cubit/NetworkConnectivityCheck/ConnectivityCubit.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/JourneyCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Repository/auth_Repository.dart';
import 'package:loan112_app/Repository/dashboard_repository.dart';
import 'package:loan112_app/Repository/loan_application_Repository.dart';
import 'package:loan112_app/Services/http_client_php.dart';
import '../Cubit/auth_cubit/AuthCubit.dart';
import '../Services/http_client.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClass>(() => ApiClass());
  locator.registerLazySingleton<ApiClassPhp>(()=>ApiClassPhp());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<ApiClass>(),locator<ApiClassPhp>()));
  locator.registerFactory(() => AuthCubit(locator<AuthRepository>()));
  locator.registerLazySingleton<LoanApplicationRepository>(()=> LoanApplicationRepository(locator<ApiClass>(),locator<ApiClassPhp>()));
  locator.registerFactory(()=> LoanApplicationCubit(locator<LoanApplicationRepository>()));

  locator.registerLazySingleton<DashBoardRepository>(()=> DashBoardRepository(locator<ApiClassPhp>()));
  locator.registerFactory(()=> DashboardCubit(locator<DashBoardRepository>()));
  locator.registerFactory(()=> JourneyCubit());
  locator.registerFactory(()=> ConnectivityCubit());

}