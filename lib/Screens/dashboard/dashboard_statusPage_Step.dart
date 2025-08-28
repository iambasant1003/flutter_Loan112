
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import '../../Model/GetCustomerDetailsModel.dart';
import '../../Model/SendPhpOTPModel.dart';
import '../../Utils/MysharePrefenceClass.dart';

class DashboardStatusPageStep extends StatefulWidget {
   DashboardStatusPageStep({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardStatusPageStep();
}

class _DashboardStatusPageStep extends State<DashboardStatusPageStep> {


  int currentStep = 0;
  final List<String> steps = [
    "Application Submitted",
    "Application in Review",
    "Sanction",
    "E-Sign Letter",
    "Disbursement",
  ];

  final List<String> icons = [
    ImageConstants.applicationSubmitted,
    ImageConstants.applicationReview,
    ImageConstants.applicationSanction,
    ImageConstants.applicationESign,
    ImageConstants.applicationDisbursement
  ];


  getCustomerDetailsApiCall() async {
    var otpModel = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(
        jsonDecode(otpModel));
    context.read<LoanApplicationCubit>().getCustomerDetailsApiCall({
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId
    });
  }


  @override
  void initState() {
    super.initState();
    getCustomerDetailsApiCall();
  }


  GetCustomerDetailsModel? model;
  Map<String, dynamic>? status;
  List<String> stepKeys = [
    "application_submitted",
    "application_in_review",
    "sanction",
    "esign",
    "disbursement"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoanApplicationCubit,LoanApplicationState>(
        builder: (context, state) {
          if (state is GetCustomerDetailsSuccess) {
           model = state.getCustomerDetailsModel;
            status = model!.data?.applicationStatus?.toJson() ?? {};
            currentStep = getCurrentStepDynamic(status!);
          }
          return  Column(
            children: List.generate(steps.length, (index) {
              final stepKey = stepKeys[index];
              final int stepStatus = status?[stepKey] ?? 0;

              // Determine width factor
              double widthFactor;
              if (stepStatus == 2) {
                widthFactor = 1.0;
              } else {
                widthFactor = 0.6;
              }

              // Determine colors
              Color bgColor = (stepStatus == 2)
                  ? Colors.blue.shade50
                  : Colors.grey.shade100;

              Color textColor = (stepStatus == 2)
                  ? Colors.black
                  : ColorConstant.greyTextColor;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Stack(
                  children: [
                    // Base layer
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // Progress step with dynamic width and styles
                    Container(
                      width: MediaQuery.of(context).size.width * widthFactor,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      child: Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              steps[index],
                              style: TextStyle(
                                fontWeight: FontConstants.w700,
                                fontSize: FontConstants.f16,
                                fontFamily: FontConstants.fontFamily,
                                color: textColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: ColorConstant.drawerHeaderColor,
                            radius: 18,
                            child: Image.asset(
                              icons[index],
                              color: textColor,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ); // fallback when no state
        },
        listener: (context,state){
          if(state is LoanApplicationLoading){
            EasyLoading.show(status: "Please Wait...");
          }else if(state is GetCustomerDetailsSuccess){
            EasyLoading.dismiss();
          }else if(state is GetCustomerDetailsError){
            EasyLoading.dismiss();
          }
        }
    );
  }


  int getCurrentStepDynamic(Map<String, dynamic> status) {
    final List<String> stepOrder = [
      "application_submitted",
      "application_in_review",
      "sanction",
      "esign",
      "disbursement"
    ];

    int step = 0;
    for (int i = 0; i < stepOrder.length; i++) {
      if (status[stepOrder[i]] == 2) {
        step = i + 1;
      }
    }
    return step;
  }

}
