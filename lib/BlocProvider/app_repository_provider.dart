
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repository/auth_Repository.dart';

final appRepositoryProviders = [
  RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
  // Add more repositories
];
