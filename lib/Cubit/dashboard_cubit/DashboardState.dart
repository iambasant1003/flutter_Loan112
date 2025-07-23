

import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Model/DeleteCustomerModel.dart';

import '../../Model/DeleteProfileOTPVerifyModel.dart';


abstract class DashboardState {}

class DashBoardInitial extends DashboardState {}

class DashBoardLoading extends DashboardState {}

class DashBoardSuccess extends DashboardState {
  final DashBoarddataModel dashBoardModel;
  DashBoardSuccess(this.dashBoardModel);
}

class DashBoardError extends DashboardState{
  final DashBoarddataModel dashBoardModel;
  DashBoardError(this.dashBoardModel);
}

class DeleteCustomerSuccess extends DashboardState{
  final DeleteCustomerModel deleteCustomerModel;
  DeleteCustomerSuccess(this.deleteCustomerModel);
}

class DeleteCustomerFailed extends DashboardState{
  final DeleteCustomerModel deleteCustomerModel;
  DeleteCustomerFailed(this.deleteCustomerModel);
}

class DeleteOTPVerified extends DashboardState{
  final DeleteProfileOTPVerifyModel deleteProfileOTPVerifyModel;
  DeleteOTPVerified(this.deleteProfileOTPVerifyModel);
}

class DeleteOTPFailed extends DashboardState{
  final DeleteProfileOTPVerifyModel deleteProfileOTPVerifyModel;
  DeleteOTPFailed(this.deleteProfileOTPVerifyModel);
}

