import 'package:get_it/get_it.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Repository/auth_Repository.dart';
import 'package:loan112_app/Repository/loan_application_Repository.dart';

import '../Cubit/auth_cubit/AuthCubit.dart';
import '../Services/http_client.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClass>(() => ApiClass());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<ApiClass>()));
  locator.registerFactory(() => AuthCubit(locator<AuthRepository>()));
  locator.registerLazySingleton<LoanApplicationRepository>(()=> LoanApplicationRepository(locator<ApiClass>()));
  locator.registerFactory(()=> LoanApplicationCubit(locator<LoanApplicationRepository>()));

}