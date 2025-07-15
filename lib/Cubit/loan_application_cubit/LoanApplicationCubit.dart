import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import '../../Repository/loan_application_Repository.dart';

class LoanApplicationCubit extends Cubit<LoanApplicationState> {
  final LoanApplicationRepository loanApplicationRepository;

  LoanApplicationCubit(this.loanApplicationRepository) : super(LoanApplicationInitial());




}