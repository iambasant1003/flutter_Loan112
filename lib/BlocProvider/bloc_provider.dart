import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/NetworkConnectivityCheck/ConnectivityCubit.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/JourneyCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';

import '../Cubit/auth_cubit/AuthCubit.dart';
import '../Repository/auth_Repository.dart';
import '../di/di_locator.dart';



final List<BlocProvider> appBlocProviders = [
  BlocProvider<AuthCubit>(
    create: (_) => locator<AuthCubit>(),
  ),
  BlocProvider<LoanApplicationCubit>(
    create: (_) => locator<LoanApplicationCubit>(),
  ),
  BlocProvider<DashboardCubit>(
    create: (_) => locator<DashboardCubit>(),
  ),
  BlocProvider<JourneyCubit>(
    create: (_) => locator<JourneyCubit>(),
  ),
  BlocProvider<ConnectivityCubit>(
    create: (_) => locator<ConnectivityCubit>(),
  ),
];
