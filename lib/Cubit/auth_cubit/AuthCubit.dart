
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loan112_app/Constant/PageKeyConstant/PageKeyConstant.dart';
import 'package:loan112_app/Model/SendOTPModel.dart';
import 'package:loan112_app/Model/SendPhpOTPModel.dart';
import 'package:loan112_app/ParamModel/SendOTPPramNodeModel.dart';
import 'package:loan112_app/ParamModel/SendOTPPramPHPModel.dart';
import 'package:loan112_app/Services/ApiResponseStatus.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import '../../Repository/auth_Repository.dart';
import '../../Utils/validation.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());


  Future<void> sendOtpNode(String phoneNumber) async {
    //emit(AuthLoading());

    SendOTPPramNodeModel sendOTPPramNodeModel = SendOTPPramNodeModel();
    sendOTPPramNodeModel.mobile = phoneNumber.trim().toString();

    try {
      final response = await authRepository.sendOTPNodeApiCallFunction(sendOTPPramNodeModel.toJson());
      if (response.status == ApiResponseStatus.success) {
        emit(AuthNodeSuccess(response.data!));
      } else {
        emit(AuthError(response.error?.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(AuthError("UnExpected Error"));
    }
  }



  Future<void> sendBothOtp(String phoneNumber) async {
    DebugPrint.prt("Indide Method");
    emit(AuthLoading());
    final position = await getCurrentPosition();
    final geoLat = position.latitude.toString();
    final geoLong = position.longitude.toString();
    final deviceId = await getDeviceId();

    DebugPrint.prt("Position $position,GeoLat $geoLat,GeoLang $geoLong,DeviceId $deviceId");

    SendOTPPramPHPModel sendOtpParamPHPModel = SendOTPPramPHPModel();
    sendOtpParamPHPModel.currentPage = pageLogin.toString();
    sendOtpParamPHPModel.mobile = phoneNumber.trim().toString();
    sendOtpParamPHPModel.isExistingCustomer = 0;
    sendOtpParamPHPModel.adjustAdid = 1;
    sendOtpParamPHPModel.adjustGpsId = 1;
    sendOtpParamPHPModel.adjustIdfa = 1;
    sendOtpParamPHPModel.pancard = "";
    sendOtpParamPHPModel.geoLat = geoLat;
    sendOtpParamPHPModel.geoLong = geoLong;
    sendOtpParamPHPModel.utmSource = "";
    sendOtpParamPHPModel.utmMedium = "";
    sendOtpParamPHPModel.utmCampaign = "";
    sendOtpParamPHPModel.fcmToken = "";
    sendOtpParamPHPModel.appfylerUid = "";
    sendOtpParamPHPModel.appfylerAdvertiserId = "";
    sendOtpParamPHPModel.deviceId = deviceId ?? "";

    SendOTPPramNodeModel sendOTPPramNodeModel = SendOTPPramNodeModel();
    sendOTPPramNodeModel.mobile = phoneNumber.trim().toString();




    try {
     var responseList = await Future.wait([
      authRepository.sendOTPNodeApiCallFunction(sendOTPPramNodeModel.toJson()),
       authRepository.sendOTPhpApiCallFunction(sendOtpParamPHPModel.toJson())
      ]);
      if(responseList[0].status == ApiResponseStatus.success &&
          responseList[1].status == ApiResponseStatus.success){
        SendOTPModel sendOTPModel = SendOTPModel.fromJson(jsonDecode(jsonEncode(responseList[0].data)));
        emit(AuthNodeSuccess(sendOTPModel));
        SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(jsonEncode(responseList[1].data)));
        emit(AuthPhpSuccess(sendPhpOTPModel));
      }
      else{
        if(responseList[0].status != ApiResponseStatus.success){
          SendOTPModel sendOTPModel = SendOTPModel.fromJson(jsonDecode(jsonEncode(responseList[0].error)));
          emit(AuthError(sendOTPModel.message ?? "Unknown Error"));
        }else if(responseList[1].status != ApiResponseStatus.success){
          SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(jsonEncode(responseList[1].error)));
          emit(AuthError(sendPhpOTPModel.message ?? "Unknown Error"));
        }
      }
    } catch (e) {
      DebugPrint.prt("Error in one of the OTP APIs: $e");
      emit(AuthError("something went wrong"));
    }
  }




  /*
  Future<void> sendOtpHp(String phoneNumber) async {
    try {
      final position = await getCurrentPosition();
      final geoLat = position.latitude.toString();
      final geoLong = position.longitude.toString();
      final deviceId = await getDeviceId();

      DebugPrint.prt("Position $position,GeoLat $geoLat,GeoLang $geoLong,DeviceId $deviceId");

      SendOTPPramPHPModel sendOtpParamPHPModel = SendOTPPramPHPModel();
      sendOtpParamPHPModel.currentPage = pageLogin.toString();
      sendOtpParamPHPModel.mobile = phoneNumber.trim().toString();
      sendOtpParamPHPModel.isExistingCustomer = 0;
      sendOtpParamPHPModel.adjustAdid = 1;
      sendOtpParamPHPModel.adjustGpsId = 1;
      sendOtpParamPHPModel.adjustIdfa = 1;
      sendOtpParamPHPModel.pancard = "";
      sendOtpParamPHPModel.geoLat = geoLat;
      sendOtpParamPHPModel.geoLong = geoLong;
      sendOtpParamPHPModel.utmSource = "";
      sendOtpParamPHPModel.utmMedium = "";
      sendOtpParamPHPModel.utmCampaign = "";
      sendOtpParamPHPModel.fcmToken = "";
      sendOtpParamPHPModel.appfylerUid = "";
      sendOtpParamPHPModel.appfylerAdvertiserId = "";
      sendOtpParamPHPModel.deviceId = deviceId ?? "";

      emit(AuthLoading());

      final response = await authRepository.sendOTPhpApiCallFunction(sendOtpParamPHPModel.toJson());



      if (response.status == ApiResponseStatus.success) {
        emit(AuthPhpSuccess(response.data!));
      } else {
        DebugPrint.prt("Error Message ${response.error?.message}");
        emit(AuthError(response.error?.message ?? "Unknown error"));
      }
    } catch (e) {
      DebugPrint.prt('Exception $e');
      emit(AuthError("something went wrong"));
    }
  }

   */




  Future<String> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;  // or androidInfo.androidId
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? "";
    }
    return "";
  }


  Future<void> verifyOtpNode(String phoneNumber,String otp) async {
    emit(VerifyOtpLoading());
    try {
      final response = await authRepository.verifyOTPNodeApiCallFunction({
        "mobile":phoneNumber,
        "otp":otp
      });
      DebugPrint.prt("Verify OTP Success $response");
      if (response.status == ApiResponseStatus.success) {
        emit(VerifyOTPSuccess(response.data!));
      } else {
        emit(AuthError(response.error?.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOtpPhp(String phoneNumber,String otp) async {
    var customerData = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(customerData));
    Map<String, dynamic> otpVerifyRequest = {
      "current_page": "otp_verify",
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId ?? "",
      "mobile": phoneNumber,
      "otp": int.parse(otp)
    };

    emit(VerifyOtpLoading());
    try {
      final response = await authRepository.verifyOTPpHpApiCallFunction(otpVerifyRequest);
      DebugPrint.prt("Verify OTP Success $response");
      if (response.status == ApiResponseStatus.success) {
        emit(VerifyPhpOTPSuccess(response.data!));
      } else {
        emit(AuthError(response.error?.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

}
