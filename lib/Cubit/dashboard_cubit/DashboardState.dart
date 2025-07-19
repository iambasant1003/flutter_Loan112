

import 'package:loan112_app/Model/DashBoarddataModel.dart';


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

