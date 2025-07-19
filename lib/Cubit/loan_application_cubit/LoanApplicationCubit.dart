

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import '../../Repository/loan_application_Repository.dart';
import '../../Services/ApiResponseStatus.dart';

class LoanApplicationCubit extends Cubit<LoanApplicationState> {
  final LoanApplicationRepository loanApplicationRepository;

  LoanApplicationCubit(this.loanApplicationRepository) : super(LoanApplicationInitial());




  Future<void> checkEligibilityApiCall(Map<String,dynamic> dataObj) async {
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

  Future<void> uploadSelfieApiCall(Map<String,dynamic> dataObj) async {
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


}