

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardState.dart';
import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Model/DeleteCustomerModel.dart';
import 'package:loan112_app/Model/SendPhpOTPModel.dart';
import 'package:loan112_app/ParamModel/DeleteCustomerProfileModel.dart';
import 'package:loan112_app/Repository/dashboard_repository.dart';
import '../../Model/DeleteProfileOTPVerifyModel.dart';
import '../../ParamModel/DeleteVerifyOTPParamModel.dart';
import '../../Services/ApiResponseStatus.dart';
import '../../Utils/Debugprint.dart';
import '../../Utils/MysharePrefenceClass.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashBoardRepository dashBoardRepository;

  DashboardCubit(this.dashBoardRepository) : super(DashBoardInitial());


  Future<void> callDashBoardApi() async {
    try {
      final dashBoardData = await MySharedPreferences.getPhpOTPModel();
      final SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(dashBoardData));
      final profileId = sendPhpOTPModel.data?.custProfileId?.trim();

      emit(DashBoardLoading());

      final response = await dashBoardRepository.dashBoardApiCallFunction(
          { "cust_profile_id": "$profileId" }
      );
      if (response.status == ApiResponseStatus.success) {
        DebugPrint.prt("DashBoard data Success");
        emit(DashBoardSuccess(response.data!));
      } else {
        emit(DashBoardError(response.error!));
      }
    } catch (e, stacktrace) {
      DebugPrint.prt('Dashboard API Exception: $e\n$stacktrace');
      emit(DashBoardError(
          DashBoarddataModel.fromJson({
            "status": "Unknown",
            "message": "Unknown Error: $e",
            "data": null
          })
      ));
    }
  }


  Future<void> callDeleteCustomerProfileApi() async {
    try {
      final dashBoardData = await MySharedPreferences.getPhpOTPModel();
      final SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(dashBoardData));
      final profileId = sendPhpOTPModel.data?.custProfileId?.trim();

      DeleteCustomerProfileModel deleteCustomerProfileModel = DeleteCustomerProfileModel();
      deleteCustomerProfileModel.currentPage = "delete_profile_send_otp";
      deleteCustomerProfileModel.custProfileId = profileId;


      emit(DashBoardLoading());

      final response = await dashBoardRepository.deleteCustomerApiCallFunction(deleteCustomerProfileModel.toJson());
      if (response.status == ApiResponseStatus.success) {
        DebugPrint.prt("Customer Profile Delete Success");
        emit(DeleteCustomerSuccess(response.data!));
      } else {
        emit(DeleteCustomerFailed(response.error!));
      }

    } catch (e, stacktrace) {
      DebugPrint.prt('Dashboard API Exception: $e\n$stacktrace');
      emit(DeleteCustomerFailed(
          DeleteCustomerModel.fromJson({
            "status": "Unknown",
            "message": "Unknown Error: $e",
            "data": null
          })
      ));
    }
  }

  Future<void>  callCustomerProfileOTPVerify(String otpValue) async{
    try {

      final dashBoardData = await MySharedPreferences.getPhpOTPModel();
      final SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(dashBoardData));
      final profileId = sendPhpOTPModel.data?.custProfileId?.trim();
      DeleteVerifyOTPParamModel deleteVerifyOTPParamModel = DeleteVerifyOTPParamModel();
      deleteVerifyOTPParamModel.custProfileId = profileId;
      deleteVerifyOTPParamModel.currentPage = "delete_profile_verify_otp";
      deleteVerifyOTPParamModel.deleteProfileConsent = 1;
      deleteVerifyOTPParamModel.deleteProfileOtp = int.parse(otpValue);

      emit(DashBoardLoading());
      final response = await dashBoardRepository.verifyDeleteOTPApiCallFunction(deleteVerifyOTPParamModel.toJson());
      if (response.status == ApiResponseStatus.success) {
        DebugPrint.prt("Customer Profile OTP Delete Success");
        emit(DeleteOTPVerified(response.data!));
      } else {
        emit(DeleteOTPFailed(response.error!));
      }
    } catch (e, stacktrace) {
      DebugPrint.prt('Dashboard API Exception: $e\n$stacktrace');
      emit(DeleteOTPFailed(
          DeleteProfileOTPVerifyModel.fromJson({
            "status": "Unknown",
            "message": "Unknown Error",
            "data": null
          })
      ));
    }
  }



}