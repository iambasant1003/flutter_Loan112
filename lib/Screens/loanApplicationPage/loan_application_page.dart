import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardState.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/Model/SendPhpOTPModel.dart';
import 'package:loan112_app/Model/VerifyPHPOTPModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/circular_progress.dart';
import '../../Constant/ColorConst/ColorConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../../Cubit/dashboard_cubit/DashboardCubit.dart';
import '../../Cubit/loan_application_cubit/JourneyCubit.dart';
import '../../Model/GetCustomerDetailsModel.dart';
import '../../Model/VerifyOTPModel.dart';
import '../../Utils/MysharePrefenceClass.dart';
import '../../Utils/validation.dart';
import '../../Widget/common_step.dart';

class LoanApplicationPage extends StatefulWidget{
  const LoanApplicationPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoanApplicationPage();
}

class _LoanApplicationPage extends State<LoanApplicationPage> {




  final List<String> step = [
    "check_eligibility",
    "ekyc_verified",
    "selfie_upload",
    "bank_statement_upload",
    "loan_quote",
    "residence_proof_upload",
    "customer_references",
    "banking_details"
  ];

  final List<String> stepKeys = [
    "Check Eligibility",
    "eKYC",
    "Selfie Verification",
    "Fetch Bank Statement",
    "Get Loan Offer",
    "Current Residence Proof",
    "Add References",
    "Banking Details"
  ];

  @override
  void initState() {
    super.initState();
    context.read<JourneyCubit>().updateJourneyTabs(
        {}
    );
    getCustomerDetailsApiCall();
  }


  getCustomerDetailsApiCall() async{
    context.read<DashboardCubit>().callDashBoardApi();
    var otpModel = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(otpModel));
    context.read<LoanApplicationCubit>().getCustomerDetailsApiCall({
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId
    });
  }

  GetCustomerDetailsModel? getCustomerDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Loan112AppBar(
        customLeading: InkWell(
          onTap: (){
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios,color: ColorConstant.blackTextColor),
        ),
        title: Text(
          "Your Loan Application",
          style: TextStyle(
            fontSize: FontConstants.f18,
            fontWeight: FontConstants.w700,
            fontFamily: FontConstants.fontFamily,
            color: ColorConstant.blackTextColor
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffE7F3FF),
      ),
      body: BlocListener<LoanApplicationCubit,LoanApplicationState>(
          listenWhen: (prevState,currentState){
            return prevState != currentState;
          },
          listener: (context,state){
            if(state is LoanApplicationLoading){
              EasyLoading.show(status: "Please wait...");
            }else if(state is GetCustomerDetailsSuccess){
              EasyLoading.dismiss();
              MySharedPreferences.setCustomerDetails(jsonEncode(state.getCustomerDetailsModel.data?.customerDetails));
              context.read<JourneyCubit>().updateJourneyTabs(
                  state.getCustomerDetailsModel.data?.screenDetails!.toJson() as Map<String,dynamic>
              );
              getCustomerDetailsModel = state.getCustomerDetailsModel;
              MySharedPreferences.setEnhanceKey((state.getCustomerDetailsModel.data?.screenDetails?.isEnhance ?? "").toString());
              setState(() {});
            }else if(state is GetCustomerDetailsError){
              EasyLoading.dismiss();
              openSnackBar(context, state.getCustomerDetailsModel.message ?? "Unknown Error");
            }else if(state is CalculateDistanceSuccess){
              EasyLoading.dismiss();
              openSnackBar(context, "Distance Mapped",backGroundColor: ColorConstant.appThemeColor);
              getCustomerDetailsApiCall();
            }else if(state is CalculateDistanceFailed){
              EasyLoading.dismiss();
            }
          },
          child: RefreshIndicator(
              onRefresh: () async{
                getCustomerDetailsApiCall();
              },
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        ImageConstants.permissionScreenBackground,
                        fit: BoxFit.cover, // Optional: to scale and crop nicely
                      ),
                    ),
                    Positioned(
                      left: 15,
                      right: 15,
                      top: 20,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocBuilder<DashboardCubit,DashboardState>(
                              builder: (context,state){
                                if(state is DashBoardSuccess){
                                  return Row(
                                    children: [
                                      SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: CircularProgressWithText(
                                          progress: (state.dashBoardModel.data?.applyLoanBanner?.appBannerProgressPercent ?? 0) / 100,
                                          isDrawer: false,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.dashBoardModel.data?.applyLoanBanner?.appBannerText?? "",
                                          //"Begin your journey to financial empowerment-provide the necessary details to initiate your loan application.",
                                          style: TextStyle(
                                              fontFamily: FontConstants.fontFamily,
                                              fontWeight: FontConstants.w500,
                                              fontSize: FontConstants.f14,
                                              color: ColorConstant.dashboardTextColor
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }else{
                                  return SizedBox();
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            // 👇 Wrap with Expanded
                            if(getCustomerDetailsModel != null)...[
                              BlocBuilder<JourneyCubit,Map<String,dynamic>>(
                                builder: (context,state){
                                  DebugPrint.prt("All Step with key $state");
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: stepKeys.length,
                                      itemBuilder: (context, index) {
                                        final stepKey = step[index];
                                        final int? status = int.tryParse(state[stepKey].toString());
                                        DebugPrint.prt("Status and Key $status,$stepKey");

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap:(){
                                                DebugPrint.prt("Current Status $status");
                                                if(status == null){
                                                  if(stepKeys[index].toLowerCase().contains('eligibility')){
                                                    context.push(AppRouterName.checkEligibilityPage).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }
                                                }else{
                                                  if(stepKeys[index].toLowerCase().contains('eligibility') && status !=1 && status != 0){
                                                    context.push(AppRouterName.checkEligibilityPage).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }else if(stepKeys[index].toLowerCase().contains('statement') && status != 1 && status != 0){
                                                    context.push(AppRouterName.bankStatement).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }else if(stepKeys[index].toLowerCase().contains('ekyc')&& status !=1 && status != 0){
                                                    context.push(AppRouterName.aaDarKYCScreen).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }else if(stepKeys[index].toLowerCase().contains('selfie')&& status!=1 && status != 0){
                                                    context.push(AppRouterName.selfieScreenPath).then((val){});
                                                  }else if(stepKeys[index].toLowerCase().contains("offer") &&status!=1 && status != 0){
                                                    context.push(AppRouterName.loanOfferPage,extra: getCustomerDetailsModel?.data?.screenDetails?.isEnhance).then((val){});
                                                  }else if(stepKeys[index].toLowerCase().contains('reference')&&status!=1 && status != 0){
                                                    context.push(AppRouterName.addReference).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }else if(stepKeys[index].toLowerCase().contains('residence') &&status!=1 && status != 0){
                                                    context.push(AppRouterName.utilityBillScreen).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }else if(stepKeys[index].toLowerCase().contains('bank')&&status!=1 && status != 0){
                                                    context.push(AppRouterName.bankDetailsScreen).then((val){
                                                      getCustomerDetailsApiCall();
                                                    });
                                                  }
                                                }
                                              },
                                              child: StepItem(
                                                title: stepKeys[index],
                                                status: status ?? 0,
                                              ),
                                            ),
                                            // add line below except for last item
                                            if (index != stepKeys.length - 1)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: Container(
                                                  height: 12,
                                                  width: 2,
                                                  color: status ==1
                                                      ? Color(0xFF5171DA) // completed line color
                                                      : Colors.grey.shade300, // pending line color
                                                ),
                                              ),
                                            if(index == stepKeys.length-1)
                                              SizedBox(
                                                height: 20,
                                              )
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                            SizedBox(
                              height: 20.0,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
      )
    );
  }


}

