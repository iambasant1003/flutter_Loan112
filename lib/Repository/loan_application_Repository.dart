
import 'package:dio/dio.dart';
import 'package:loan112_app/Model/CreateLeadModel.dart';
import 'package:loan112_app/Model/CustomerKycModel.dart';
import 'package:loan112_app/Model/EkycVerifictionModel.dart';
import 'package:loan112_app/Model/GenerateLoanOfferModel.dart';
import 'package:loan112_app/Model/GetCustomerDetailsModel.dart';
import 'package:loan112_app/Model/GetPinCodeDetailsModel.dart';
import 'package:loan112_app/Model/UploadSelfieModel.dart';
import 'package:loan112_app/Services/http_client_php.dart';
import '../Constant/ApiUrlConstant/ApiUrlConstant.dart';
import '../Services/ApiResponseStatus.dart';
import '../Services/http_client.dart';
import '../Utils/Debugprint.dart';

class LoanApplicationRepository {
  final ApiClass apiClass;
  final ApiClassPhp apiClassPhp;
  LoanApplicationRepository(this.apiClass,this.apiClassPhp);


  ApiResponseStatus mapApiResponseStatus(dynamic responseBody) {
    final Map<String, dynamic> decoded = responseBody;

    final int? logicalStatusCode = decoded['statusCode'];

    if (logicalStatusCode == null) {
      // Fallback: if no logical status code found, treat as failure
      return ApiResponseStatus.notFound;
    }

    return mapStatusCode(logicalStatusCode);
  }


  Future<ApiResponse<CreateLeadModel>> checkEligibilityFunction(Map<String,dynamic> dataObj) async{
    try {
      final response = await apiClass.post(checkEligibility, dataObj, isHeader: true);
      DebugPrint.prt("API Response AreaWise Data ${response.data}");

      final Map<String, dynamic> responseData = response.data;

      final int statusCode = responseData['statusCode'] ?? 500;
      final ApiResponseStatus status = mapStatusCode(statusCode);

      if (status == ApiResponseStatus.success) {
        final data = CreateLeadModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = CreateLeadModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.statusCode}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in checkEligibilityFunction: $e");
      final error = CreateLeadModel(
        statusCode: 500,
        message: "Unknown error occurred",
        success: false,
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }


  Future<ApiResponse<GetPinCodeDetailsModel>> getPinCodeDetailsFunction(String pinCode) async{
    try {
      final response = await apiClass.get("$getPinCodeDetails?pincode=$pinCode", isHeader: true);
      DebugPrint.prt("API Response AreaWise Data ${response.data}");
      final ApiResponseStatus status = mapApiResponseStatus(response.data);
      final Map<String, dynamic> responseData = response.data;
      if (status == ApiResponseStatus.success) {
        final data = GetPinCodeDetailsModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = GetPinCodeDetailsModel.fromJson(responseData);
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      throw e.toString();
    }
  }


  Future<ApiResponse<UploadSelfieModel>> uploadSelfieFunction(FormData dataObj) async{
    try {
      final response = await apiClass.post(uploadSelfie, dataObj, isHeader: true,isMultipart: true);
      DebugPrint.prt("API Response Upload Selfie Data ${response.data}");

      final Map<String, dynamic> responseData = response.data;

      final int statusCode = responseData['statusCode'] ?? 500;
      final ApiResponseStatus status = mapStatusCode(statusCode);

      if (status == ApiResponseStatus.success) {
        final data = UploadSelfieModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = UploadSelfieModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.statusCode}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in Upload Selfie: $e");
      final error = UploadSelfieModel(
        statusCode: 500,
        message: "Unknown error occurred",
        success: false,
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }

  Future<ApiResponse<GetCustomerDetailsModel>> getCustomerDetailsFunction(Map<String,dynamic> dataObj) async{
    try {
      final response = await apiClassPhp.post(getCustomerDetailsPHP, dataObj, isHeader: true);
      DebugPrint.prt("API Response GetCustomer Details Data ${response.data}");

      final Map<String, dynamic> responseData = response.data;

      final int statusCode = responseData['Status'] ?? 500;
      final ApiResponseStatus status = mapStatusCodePhp(statusCode);

      if (status == ApiResponseStatus.success) {
        final data = GetCustomerDetailsModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = GetCustomerDetailsModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.status}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in get Customer Details: $e");
      final error = GetCustomerDetailsModel(
        status: 500,
        message: "Unknown error occurred",
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }


  Future<ApiResponse<CustomerKycModel>> customerKYCFunction(Map<String,dynamic> dataObj) async{
    try {
      final response = await apiClass.post(customerKyc, dataObj, isHeader: true);
      DebugPrint.prt("API Response Customer KYC data ${response.data}");

      final Map<String, dynamic> responseData = response.data;


      final ApiResponseStatus status = mapApiResponseStatus(responseData);

      if (status == ApiResponseStatus.success) {
        final data = CustomerKycModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = CustomerKycModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.statusCode}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in get Customer Details: $e");
      final error = CustomerKycModel(
        statusCode: 500,
        message: "Unknown error occurred",
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }


  Future<ApiResponse<EkycVerificationModel>> customerKYCVerificationFunction(Map<String,dynamic> dataObj) async{
    try {
      final response = await apiClass.put(customerKycVerification, dataObj, isHeader: true);
      DebugPrint.prt("API Response Customer KYC data ${response.data}");

      final Map<String, dynamic> responseData = response.data;


      final ApiResponseStatus status = mapApiResponseStatus(responseData);

      if (status == ApiResponseStatus.success) {
        final data = EkycVerificationModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = EkycVerificationModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.statusCode}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in get Customer Details: $e");
      final error = EkycVerificationModel(
        statusCode: 500,
        message: "Unknown error occurred",
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }

  Future<ApiResponse<GenerateLoanOfferModel>> generateLoanOfferApiCallFunction(Map<String,dynamic> dataObj) async{
    try {
      final response = await apiClass.post(generateLoanOffer, dataObj, isHeader: true);
      DebugPrint.prt("API Response Generate Loan Offer data ${response.data}");

      final Map<String, dynamic> responseData = response.data;


      final ApiResponseStatus status = mapApiResponseStatus(responseData);

      if (status == ApiResponseStatus.success) {
        final data = GenerateLoanOfferModel.fromJson(responseData);
        return ApiResponse.success(data);
      } else {
        final error = GenerateLoanOfferModel.fromJson(responseData);
        DebugPrint.prt("Error Message ${error.message}, ${error.statusCode}");
        return ApiResponse.error(status, error: error);
      }
    } catch (e) {
      DebugPrint.prt("Exception in get Customer Details: $e");
      final error = GenerateLoanOfferModel(
        statusCode: 500,
        message: "Unknown error occurred",
      );
      return ApiResponse.error(ApiResponseStatus.serverError, error: error);
    }
  }

}

