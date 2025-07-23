

import 'package:loan112_app/Model/CreateLeadModel.dart';
import 'package:loan112_app/Model/CustomerKycModel.dart';
import 'package:loan112_app/Model/EkycVerifictionModel.dart';
import 'package:loan112_app/Model/GenerateLoanOfferModel.dart';
import 'package:loan112_app/Model/GetCustomerDetailsModel.dart';
import 'package:loan112_app/Model/GetPinCodeDetailsModel.dart';
import 'package:loan112_app/Model/GetPurposeOfLoanModel.dart';
import 'package:loan112_app/Model/GetUtilityDocTypeModel.dart';
import 'package:loan112_app/Model/LoanAcceptanceModel.dart';
import 'package:loan112_app/Model/UploadSelfieModel.dart';
import 'package:loan112_app/Model/UploadUtilityDocTypeModel.dart';

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

class CustomerKYCVerificationSuccess extends LoanApplicationState{
  final EkycVerificationModel ekycVerificationModel;
  CustomerKYCVerificationSuccess(this.ekycVerificationModel);
}

class CustomerKYCVerificationError extends LoanApplicationState{
  final EkycVerificationModel ekycVerificationModel;
  CustomerKYCVerificationError(this.ekycVerificationModel);
}

class GenerateLoanOfferSuccess extends LoanApplicationState{
  GenerateLoanOfferModel? generateLoanOfferModel;
  GetPurposeOfLoanModel? getPurposeOfLoanModel;
  GenerateLoanOfferSuccess(this.generateLoanOfferModel,this.getPurposeOfLoanModel);
}

class GetPurposeOfLoanSuccess extends LoanApplicationState{
  final GetPurposeOfLoanModel getPurposeOfLoanModel;
  GetPurposeOfLoanSuccess(this.getPurposeOfLoanModel);
}

class GetPurposeOfLoanFailed extends LoanApplicationState{
  final GetPurposeOfLoanModel getPurposeOfLoanModel;
  GetPurposeOfLoanFailed(this.getPurposeOfLoanModel);
}

class GenerateLoanOfferError extends LoanApplicationState{
  final GenerateLoanOfferModel generateLoanOfferModel;
  GenerateLoanOfferError(this.generateLoanOfferModel);
}

class LoanAcceptanceLoading extends LoanApplicationState{}

class LoanAcceptanceSuccess extends LoanApplicationState{
 final LoanAcceptanceModel loanAcceptanceModel;
 LoanAcceptanceSuccess(this.loanAcceptanceModel);
}

class LoanAcceptanceError extends LoanApplicationState{
  final LoanAcceptanceModel loanAcceptanceModel;
  LoanAcceptanceError(this.loanAcceptanceModel);
}

class GetUtilityDocTypeLoaded extends LoanApplicationState{
  final GetUtilityDocTypeModel getUtilityDocTypeModel;
  GetUtilityDocTypeLoaded(this.getUtilityDocTypeModel);
}

class UploadUtilityDocSuccess extends LoanApplicationState{
  final UploadUtilityDocTypeModel uploadUtilityDocTypeModel;
  UploadUtilityDocSuccess(this.uploadUtilityDocTypeModel);
}

class UploadUtilityDocError extends LoanApplicationState{
  final String errorMessage;
  UploadUtilityDocError(this.errorMessage);
}



