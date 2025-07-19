

import 'package:loan112_app/Model/CreateLeadModel.dart';
import 'package:loan112_app/Model/CustomerKycModel.dart';
import 'package:loan112_app/Model/GetCustomerDetailsModel.dart';
import 'package:loan112_app/Model/GetPinCodeDetailsModel.dart';
import 'package:loan112_app/Model/UploadSelfieModel.dart';

abstract class LoanApplicationState {}

class LoanApplicationInitial extends LoanApplicationState {}

class LoanApplicationLoading extends LoanApplicationState {}


class LoanApplicationLoaded extends LoanApplicationState {
  final UploadSelfieModel data;
  LoanApplicationLoaded(this.data);
}

class LoanApplicationError extends LoanApplicationState {
  final String message;
  LoanApplicationError(this.message);
}


class CreateLeadSuccess extends LoanApplicationState{
  final CreateLeadModel createLeadModel;
  CreateLeadSuccess(this.createLeadModel);
}

class CreateLeadError extends LoanApplicationState{
  final CreateLeadModel createLeadModel;
  CreateLeadError(this.createLeadModel);
}

class GetPinCodeDetailsSuccess extends LoanApplicationState{
  final GetPinCodeDetailsModel pinCodeDetailsModel;
  GetPinCodeDetailsSuccess(this.pinCodeDetailsModel);
}

class UploadSelfieSuccess extends LoanApplicationState{
  final UploadSelfieModel uploadSelfieModel;
  UploadSelfieSuccess(this.uploadSelfieModel);
}

class UploadSelfieError extends LoanApplicationState{
  final UploadSelfieModel uploadSelfieModel;
  UploadSelfieError(this.uploadSelfieModel);
}

class GetCustomerDetailsSuccess extends LoanApplicationState{
  final GetCustomerDetailsModel getCustomerDetailsModel;
  GetCustomerDetailsSuccess(this.getCustomerDetailsModel);
}

class GetCustomerDetailsError extends LoanApplicationState{
  final GetCustomerDetailsModel getCustomerDetailsModel;
  GetCustomerDetailsError(this.getCustomerDetailsModel);
}

class CustomerKYCSuccess extends LoanApplicationState{
  final CustomerKycModel customerKycModel;
  CustomerKYCSuccess(this.customerKycModel);
}

class CustomerKYCError extends LoanApplicationState{
  final CustomerKycModel customerKycModel;
  CustomerKYCError(this.customerKycModel);
}

