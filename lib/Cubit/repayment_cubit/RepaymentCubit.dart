

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan112_app/Constant/ConstText/ConstText.dart';
import 'package:loan112_app/Cubit/repayment_cubit/RepaymentState.dart';
import 'package:loan112_app/Model/CashFreePaymentInitializationResponse.dart';
import 'package:loan112_app/Model/RazorPayInitiatePaymentResponseModel.dart';
import 'package:loan112_app/ParamModel/CashFreePaymentInitializationParamModel.dart';
import 'package:loan112_app/ParamModel/CashFreePaymentStatusParamModel.dart';
import 'package:loan112_app/ParamModel/RazorPayPaymentInitialParamModel.dart';
import 'package:loan112_app/Repository/repayment_repository.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import '../../Model/CashFreePaymentResponseModel.dart';
import '../../Model/RazorPayCheckPaymentStatusModel.dart';
import '../../Model/RazorPayInitiatePaymentResponseSuccessModel.dart';
import '../../Model/VerifyOTPModel.dart';
import '../../ParamModel/CheckRazorPayPaymentStatusParamModel.dart';
import '../../Services/ApiResponseStatus.dart';

class RePaymentCubit extends Cubit<RepaymentState> {
  final RepaymentRepository repaymentRepository;

  RePaymentCubit(this.repaymentRepository) : super(RepaymentInitial());


  Future<void> initiateRazorpayPayment(String amount,String leadId) async {
    emit(RepaymentLoading());

    RazorPayPaymentInitialParamModel razorPayPaymentInitialParamModel = RazorPayPaymentInitialParamModel();
    razorPayPaymentInitialParamModel.amount = double.parse(amount);
    razorPayPaymentInitialParamModel.leadId = leadId;
    razorPayPaymentInitialParamModel.productType = 0;

    try {
      final response = await repaymentRepository.initiateRazorpayApiCallFunction(razorPayPaymentInitialParamModel.toJson());
      DebugPrint.prt("RazorPay Initiate Payment ${response.data}");
      if (response.status == ApiResponseStatus.success) {
        emit(RazorpayPaymentInitiateSuccess(response.data!));
      } else {
        emit(RazorpayPaymentInitiateFailed(response.error!));
      }
    } catch (e) {
      emit(
          RazorpayPaymentInitiateFailed(
              RazorPayInitiatePaymentResponseSuccessModel(
              status: 500,
              message: ConstText.exceptionError
            )
          )
      );
    }
  }


  Future<void> checkRazorpayPaymentStatus(String razorPaymentId,String leadId) async {
    emit(RepaymentLoading());

    CheckRazorPayPaymentStatusParamModel checkRazorPayPaymentStatusParamModel = CheckRazorPayPaymentStatusParamModel();
    checkRazorPayPaymentStatusParamModel.leadId = leadId;
    checkRazorPayPaymentStatusParamModel.razorpayPaymentId = razorPaymentId;
    checkRazorPayPaymentStatusParamModel.recoveryById = "1";
    checkRazorPayPaymentStatusParamModel.remarks = 'Loan repayment';


    try {
      final response = await repaymentRepository.completeRazorpayApiCallFunction(checkRazorPayPaymentStatusParamModel.toJson());
      DebugPrint.prt("RazorPay Payment Status Check ${response.data}");
      if (response.status == ApiResponseStatus.success) {
        emit(CheckRazorPayPaymentStatusSuccess(response.data!));
      } else {
        emit(CheckRazorPayPaymentStatusFailed(response.error!));
      }
    } catch (e) {
      emit(
          CheckRazorPayPaymentStatusFailed(
          RazorPayCheckPaymentStatusModel(
                  status: 500,
                  message: ConstText.exceptionError
              )
          )
      );
    }
  }


  Future<void> initiateCashFreePayment(String amount,String leadId) async {
    emit(RepaymentLoading());

    CashFreePaymentInitializationParamModel cashFreePaymentInitializationParamModel = CashFreePaymentInitializationParamModel();
    cashFreePaymentInitializationParamModel.amount = double.parse(amount);
    cashFreePaymentInitializationParamModel.leadId = leadId;

    try {
      final response = await repaymentRepository.initiateCashFreeApiCallFunction(cashFreePaymentInitializationParamModel.toJson());
      DebugPrint.prt("CashFree Initiate Payment ${response.data}");
      if (response.status == ApiResponseStatus.success) {
        emit(CashFreeInitiateSuccess(response.data!));
      } else {
        emit(CashFreeInitiateSuccess(response.error!));
      }
    } catch (e) {
      emit(
          CashFreeInitiateFailed(
              CashFreePaymentInitializationResponse(
                  status: 500,
                  message: ConstText.exceptionError
              )
          )
      );
    }
  }

  Future<void> checkCashFreePayment(String orderId) async {
    emit(RepaymentLoading());

    CashFreePaymentStatusParamModel cashFreePaymentStatusParamModel = CashFreePaymentStatusParamModel();
    cashFreePaymentStatusParamModel.leadId = "";
    cashFreePaymentStatusParamModel.orderId = "";

    try {
      final response = await repaymentRepository.completeCashFreePayApiCallFunction(cashFreePaymentStatusParamModel.toJson());
      DebugPrint.prt("CashFree  Payment Status Check ${response.data}");
      if (response.status == ApiResponseStatus.success) {
        emit(CashFreePaymentStatusSuccess(response.data!));
      } else {
        emit(CashFreePaymentStatusFailed(response.error!));
      }
    } catch (e) {
      emit(
          CashFreePaymentStatusFailed(
              CashFreePaymentResponseModel(
                  status: 500,
                  message: ConstText.exceptionError
              )
          )
      );
    }
  }



}


