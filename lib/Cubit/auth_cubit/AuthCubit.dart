
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Services/ApiResponseStatus.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import '../../Repository/auth_Repository.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());




  Future<void> sendOtp(String phoneNumber) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.sendOTPApiCallFunction({
        "mobile": phoneNumber,
      });
      if (response.status == ApiResponseStatus.success) {
        emit(AuthSuccess(response.data!));
      } else {
        emit(AuthError(response.error?.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyOtp(String phoneNumber,String otp) async {
    emit(VerifyOtpLoading());
    try {
      final response = await authRepository.verifyOTPApiCallFunction({
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

}
