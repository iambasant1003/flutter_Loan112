

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/Model/GenerateLoanOfferModel.dart';
import 'package:loan112_app/Model/GetPurposeOfLoanModel.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import '../../Repository/loan_application_Repository.dart';
import '../../Services/ApiResponseStatus.dart';

class LoanApplicationCubit extends Cubit<LoanApplicationState> {
  final LoanApplicationRepository loanApplicationRepository;

  LoanApplicationCubit(this.loanApplicationRepository) : super(LoanApplicationInitial());




  Future<void> checkEligibilityApiCall(Map<String,dynamic> dataObj) async {
    DebugPrint.prt("Data Object Check Eligibility $dataObj");
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.checkEligibilityFunction(dataObj);
    if (response.status == ApiResponseStatus.success) {
      emit(CreateLeadSuccess(response.data!));
    } else {
      emit(CreateLeadError(response.error!));
    }
  }

  Future<void> getPinCodeDetailsApiCall(String pinCodeData) async {
    emit(LoanApplicationLoading());
    try {
      final response = await loanApplicationRepository.getPinCodeDetailsFunction(pinCodeData);
      if (response.status == ApiResponseStatus.success) {
        emit(GetPinCodeDetailsSuccess(response.data!));
      } else {
        emit(LoanApplicationError(response.error?.message ?? "Unknown Error"));
      }
    } catch (e) {
      emit(LoanApplicationError("Something went wrong"));
    }
  }

  Future<void> uploadSelfieApiCall(FormData dataObj) async {
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.uploadSelfieFunction(dataObj);

    if (response.status == ApiResponseStatus.success) {
      emit(UploadSelfieSuccess(response.data!));
    } else {
      emit(UploadSelfieError(response.error!));
    }
  }

  Future<void> getCustomerDetailsApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.getCustomerDetailsFunction(dataObj);

    if (response.status == ApiResponseStatus.success) {
      emit(GetCustomerDetailsSuccess(response.data!));
    } else {
      emit(GetCustomerDetailsError(response.error!));
    }
  }


  Future<void> customerKycApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.customerKYCFunction(dataObj);
     DebugPrint.prt("KYC Api Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(CustomerKYCSuccess(response.data!));
    } else {
      emit(CustomerKYCError(response.error!));
    }
  }

  Future<void> customerKycVerificationApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.customerKYCVerificationFunction(dataObj);
    DebugPrint.prt("KYC Api Verification Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(CustomerKYCVerificationSuccess(response.data!));
    } else {
      emit(CustomerKYCVerificationError(response.error!));
    }
  }


  Future<void>  getPurposeOfLoanApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanApplicationLoading());
    final responseList =await Future.wait([
          loanApplicationRepository.generateLoanOfferApiCallFunction(dataObj),
          loanApplicationRepository.getPurposeOfLoanApiCallFunction(dataObj)
    ]);
    DebugPrint.prt("Status Loan Offer ${responseList[0].status}, Purpose of Loan ${responseList[1].status}");
    if(responseList[0].status == ApiResponseStatus.success &&
        responseList[1].status == ApiResponseStatus.success){
      GenerateLoanOfferModel generateLoanOfferModel = GenerateLoanOfferModel.fromJson(jsonDecode(jsonEncode(responseList[0].data)));
      GetPurposeOfLoanModel getPurposeOfLoanModel = GetPurposeOfLoanModel.fromJson(jsonDecode(jsonEncode(responseList[1].data)));
      emit(GenerateLoanOfferSuccess(generateLoanOfferModel,getPurposeOfLoanModel));
      DebugPrint.prt("Emitted generate Loan Offer");
    }
    else{
      if(responseList[0].status != ApiResponseStatus.success){
        DebugPrint.prt("InSide Else if Block ${responseList[0].error}");
        GenerateLoanOfferModel generateLoanOfferModel = GenerateLoanOfferModel.fromJson(jsonDecode(jsonEncode(responseList[0].error)));
        emit(GenerateLoanOfferError(generateLoanOfferModel));
      }else if(responseList[1].status != ApiResponseStatus.success){
        DebugPrint.prt("InSide Else else Block");
        GetPurposeOfLoanModel getPurposeOfLoanModel = GetPurposeOfLoanModel.fromJson(jsonDecode(jsonEncode(responseList[1].error)));
        emit(GetPurposeOfLoanFailed(getPurposeOfLoanModel));
      }
    }
  }


  Future<void> loanAcceptanceApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanAcceptanceLoading());
    final response = await loanApplicationRepository.loanAcceptanceApiCallFunction(dataObj);
    DebugPrint.prt("Accept Loan Offer Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(LoanAcceptanceSuccess(response.data!));
    } else {
      emit(LoanAcceptanceError(response.error!));
    }
  }

  Future<void> getUtilityTypeDocApiCall() async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.getUtilityTyeApiCallFunction();
    DebugPrint.prt("Get Utility Doc Type Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(GetUtilityDocTypeLoaded(response.data!));
    } else {
      emit(LoanApplicationError(response.error?.message ?? "Unknown Error"));
    }
  }


  Future<void> uploadUtilityTypeDocApiCall(FormData dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.uploadUtilityTypeDocApiCallFunction(dataObj);
    DebugPrint.prt("Upload Utility Doc Type Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(UploadUtilityDocSuccess(response.data!));
    } else {
      emit(UploadUtilityDocError(response.error?.message ?? "Unknown Error"));
    }
  }

  Future<void> uploadBankStatementApiCall(FormData dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.uploadBankStatementApiCallFunction(dataObj);
    DebugPrint.prt("Upload BankStatement Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(UploadBankStatementSuccess(response.data!));
    } else {
      DebugPrint.prt("Inside Else Block of response");
      emit(UploadBankStatementFailed(response.error!));
    }
  }


  Future<void> addReferenceApiCall(Map<String,dynamic> dataObj) async{
    emit(LoanApplicationLoading());
    final response = await loanApplicationRepository.addReferenceApiCallFunction(dataObj);
    DebugPrint.prt("Upload Reference Response Status ${response.status}");
    if (response.status == ApiResponseStatus.success) {
      emit(AddReferenceSuccess(response.data!));
    } else {
      DebugPrint.prt("Inside Else Block of response");
      emit(AddReferenceFailed(response.error!));
    }
  }




}

