
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Repository/loan_application_Repository.dart';
import '../Repository/auth_Repository.dart';
import '../Services/http_client.dart';

final appRepositoryProviders = [
  RepositoryProvider<AuthRepository>(
    create: (_) => AuthRepository(ApiClass()),
  ),
  RepositoryProvider<LoanApplicationRepository>(
    create: (_) => LoanApplicationRepository(ApiClass()),
  ),
  // Add more repositories
];

