

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardState.dart';
import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Model/SendPhpOTPModel.dart';
import 'package:loan112_app/Repository/dashboard_repository.dart';
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



}