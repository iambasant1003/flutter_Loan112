
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loan112_app/Constant/PageKeyConstant/PageKeyConstant.dart';
import 'package:loan112_app/Model/SendOTPModel.dart';
import 'package:loan112_app/Model/SendPhpOTPModel.dart';
import 'package:loan112_app/Services/ApiResponseStatus.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import '../../Repository/auth_Repository.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());


  Future<void> sendOtpNode(String phoneNumber) async {
    //emit(AuthLoading());
    try {
      final response = await authRepository.sendOTPNodeApiCallFunction({
        "mobile": phoneNumber,
      });
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

    final position = await getCurrentPosition();
    final geoLat = position.latitude.toString();
    final geoLong = position.longitude.toString();
    final deviceId = await getDeviceId();
    
    emit(AuthLoading());
    try {
     var responseList = await Future.wait([
      authRepository.sendOTPNodeApiCallFunction({
      "mobile": phoneNumber,
      }),
       authRepository.sendOTPhpApiCallFunction({
    "current_page": pageLogin.toString(),
    "mobile": phoneNumber.toString(),
    "is_existing_customer":0,
    "adjust_adid":1,
    "adjust_gps_id":1,
    "adjust_idfa":1,
    "pancard":"",
    "geo_lat":geoLat,
    "geo_long":geoLong,
    "utm_source":"",
    "utm_medium":"",
    "utm_campaign":"",
    "fcm_token":"",
    "appfyler_uid":"",
    "appfyler_advertiser_id":"",
    "device_id":deviceId ?? ""
    })  
      ]);
      if(responseList[0].status == ApiResponseStatus.success &&
          responseList[1].status == ApiResponseStatus.success){
        SendOTPModel sendOTPModel = SendOTPModel.fromJson(jsonDecode(jsonEncode(responseList[0].data)));
        emit(AuthNodeSuccess(sendOTPModel));
        SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(jsonEncode(responseList[1].data)));
        emit(AuthPhpSuccess(sendPhpOTPModel));
      }else{
        if(responseList[0].status != ApiResponseStatus.success){
          SendOTPModel sendOTPModel = SendOTPModel.fromJson(jsonDecode(jsonEncode(responseList[0].data)));
          emit(AuthError(sendOTPModel.message ?? "Unknown Error"));
        }else if(responseList[1].status != ApiResponseStatus.success){
          SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(jsonEncode(responseList[1].data)));
          emit(AuthError(sendPhpOTPModel.message ?? "Unknown Error"));
        }
      }
    } catch (e) {
      DebugPrint.prt("Error in one of the OTP APIs: $e");
      emit(AuthError("something went wrong"));
    }
  }




  Future<void> sendOtpHp(String phoneNumber) async {
    emit(AuthLoading());
    try {
      final position = await getCurrentPosition();
      final geoLat = position.latitude.toString();
      final geoLong = position.longitude.toString();
      final deviceId = await getDeviceId();



      final response = await authRepository.sendOTPhpApiCallFunction({
        "current_page": pageLogin.toString(),
        "mobile": phoneNumber.toString(),
        "is_existing_customer":0,
        "adjust_adid":1,
        "adjust_gps_id":1,
        "adjust_idfa":1,
        "pancard":"",
        "geo_lat":geoLat,
        "geo_long":geoLong,
        "utm_source":"",
        "utm_medium":"",
        "utm_campaign":"",
        "fcm_token":"",
        "appfyler_uid":"",
        "appfyler_advertiser_id":"",
        "device_id":deviceId ?? ""
      });



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


  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

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
