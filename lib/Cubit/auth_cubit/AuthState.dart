import 'package:loan112_app/Model/SendOTPModel.dart';

import '../../Model/VerifyOTPModel.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final SendOTPModel data;
  AuthSuccess(this.data);
}



class VerifyOtpLoading extends AuthState{}

class VerifyOTPSuccess extends AuthState{
  final VerifyOTPModel verifyOTPModel;
  VerifyOTPSuccess(this.verifyOTPModel);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
