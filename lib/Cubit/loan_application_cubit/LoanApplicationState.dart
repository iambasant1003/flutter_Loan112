

import 'package:loan112_app/Model/UploadSelfieModel.dart';

abstract class LoanApplicationState {}

class LoanApplicationInitial extends LoanApplicationState {}

class LoanApplicationLoading extends LoanApplicationState {}


class LoanApplicationLoaded extends LoanApplicationState {
  final UploadSelfieModel data;
  LoanApplicationLoaded(this.data);
}

class LoanApplicationError extends LoanApplicationState {
  final UploadSelfieModel data;
  LoanApplicationError(this.data);
}

