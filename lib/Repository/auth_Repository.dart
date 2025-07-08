
import 'dart:convert';
import 'package:loan112_app/Constant/ApiUrlConstant/ApiUrlConstant.dart';
import 'package:loan112_app/Model/VerifyOTPModel.dart';
import 'package:loan112_app/Services/ApiResponseStatus.dart';
import '../Model/SendOTPModel.dart';
import '../Model/error_model.dart';
import '../Services/http_client.dart';
import '../Utils/Debugprint.dart';

class AuthRepository {


  Future<ApiResponse<SendOTPModel>> sendOTPApiCallFunction(Map<String, dynamic> data) async {
    try {
      final response = await ApiClass.post(sendOTP, data, isHeader: false);
      DebugPrint.prt("API Response AreaWise Data ${response.body}");
      final ApiResponseStatus status = mapStatusCode(response.statusCode!);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (status == ApiResponseStatus.success) {
        final data = SendOTPModel.fromJson(responseData);
        DebugPrint.prt("ResponseData In success $responseData");
        return ApiResponse.success(data);
      } else {
        final error = ErrorModal.fromJson(responseData);
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ApiResponse<VerifyOTPModel>> verifyOTPApiCallFunction(Map<String, dynamic> data) async {
    try {
      final response = await ApiClass.post(verifyOTP, data, isHeader: false);
      DebugPrint.prt("API Response AreaWise Data ${response.body}");
      final ApiResponseStatus status = mapStatusCode(response.statusCode!);
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (status == ApiResponseStatus.success) {
        final data = VerifyOTPModel.fromJson(responseData);
        DebugPrint.prt("ResponseData In success $responseData");
        return ApiResponse.success(data);
      } else {
        final error = ErrorModal.fromJson(responseData);
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      throw e.toString();
    }
  }




}