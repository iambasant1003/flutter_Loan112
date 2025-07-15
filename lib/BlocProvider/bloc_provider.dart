import 'package:flutter_bloc/flutter_bloc.dart';
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
];
