import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/auth_cubit/AuthCubit.dart';
import '../Repository/auth_Repository.dart';



/// A shared repository instance
final AuthRepository _authRepository = AuthRepository();


final List<BlocProvider> appBlocProviders = [
  BlocProvider<AuthCubit>(
    create: (_) => AuthCubit(_authRepository),
  ),
];
