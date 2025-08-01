

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardState.dart';
import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constant/ColorConst/ColorConstant.dart';
import '../../Constant/FontConstant/FontConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../../Cubit/dashboard_cubit/DashboardCubit.dart';
import '../../Widget/circular_progress.dart';
import '../../Widget/common_button.dart';
import 'dashboard_loan_details.dart';

class DashBoardHome extends StatefulWidget{
  const DashBoardHome({super.key});

  @override
  State<StatefulWidget> createState() => _DashBoardHome();
}

class _DashBoardHome extends State<DashBoardHome>{


  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().callDashBoardApi();
  }

  final PageController _controller = PageController(
    viewportFraction: 1.0,
  );

  List<String> imageData = ["Ram","Shyam"];


  DashBoarddataModel? dashBoarddataModel;


  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit,DashboardState>(
      listenWhen: (prev,next){
        DebugPrint.prt("Previous State $prev, Current State $next");
        return prev != next;
      },
      listener: (context,state){
        if(state is DashBoardLoading){
          DebugPrint.prt('DashBoard Is Loading');
          EasyLoading.show(status: "Please Wait");
        }else if(state is DashBoardSuccess){
          EasyLoading.dismiss();
          dashBoarddataModel = state.dashBoardModel;
        }else if(state is DashBoardError){
          DebugPrint.prt("DashBoard Is facing Error");
          EasyLoading.dismiss();
          openSnackBar(context, state.dashBoardModel.message ?? "Unknown Error");
        }else if(state is DeleteCustomerSuccess){
          DebugPrint.prt("Delete Customer Success");
          EasyLoading.dismiss();
          Navigator.of(context).pop();
          context.push(AppRouterName.dashBoardOTP);
        }else if(state is DeleteCustomerFailed){
          DebugPrint.prt("Delete Customer Failed");
          Navigator.of(context).pop();
          EasyLoading.dismiss();
          openSnackBar(context, state.deleteCustomerModel.message ?? "Unexpected Error");
        }
      },
      child: BlocBuilder<DashboardCubit,DashboardState>(
          builder: (context,state){
            if(dashBoarddataModel != null){
              return commonScaffold(
                  context,
                  dashBoardModel: dashBoarddataModel,
                  bodyPart: SizedBox.expand(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            ImageConstants.permissionScreenBackground,
                            fit: BoxFit.cover, // Optional: to scale and crop nicely
                          ),
                        ),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 37,
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    personalLoanApplyWidget(context,dashBoarddataModel!),
                                    Positioned(
                                      top: -2,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorConstant.appThemeColor,
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(18.0),
                                              bottomRight: Radius.circular(18.0),
                                            ),
                                          ),
                                          width: 244,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              dashBoarddataModel?.data!.applyLoanBanner!.appBannerTitle ?? "",
                                              //"Easy personal Loans",
                                              style: TextStyle(
                                                fontFamily: FontConstants.fontFamily,
                                                fontSize: FontConstants.f18,
                                                fontWeight: FontConstants.w800,
                                                color: ColorConstant.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //This 2nd Positioned Contains Button
                                    Positioned(
                                        bottom: -15,
                                        left: 80,
                                        right: 80,
                                        child: GestureDetector(
                                          onTap: (){
                                            DebugPrint.prt("application Submitted ${dashBoarddataModel?.data?.applicationSubmitted}");
                                            DebugPrint.prt("application loan History ${dashBoarddataModel?.data?.showLoanHistoryBtnFlag}");
                                            if(dashBoarddataModel?.data?.applyLoanBanner?.appBannerBtnActiveFlag == 1
                                                && dashBoarddataModel?.data?.applicationSubmitted != 1&& dashBoarddataModel?.data?.showLoanHistoryBtnFlag != 1){
                                              context.push(AppRouterName.loanApplicationPage);
                                            }
                                            if(dashBoarddataModel?.data?.applicationSubmitted == 1
                                                && dashBoarddataModel?.data?.showLoanHistoryBtnFlag != 1){
                                              context.push(AppRouterName.dashBoardStatus);
                                            } else if(
                                            dashBoarddataModel?.data?.showLoanHistoryBtnFlag == 1&&
                                                dashBoarddataModel?.data?.applyLoanBanner?.appBannerBtnActiveFlag != 1
                                            ){
                                              context.push(AppRouterName.repaymentPage);
                                            }
                                          },
                                          child: Loan112Button(
                                              onPressed: null,
                                              text: dashBoarddataModel?.data?.applyLoanBanner?.appBannerBtnText ?? ""
                                            //"Let's Start"
                                          ),
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                (
                                    dashBoarddataModel?.data?.activeLoanDetails != null &&
                                        (dashBoarddataModel?.data?.activeLoanDetails?.loanNo != null || dashBoarddataModel?.data?.activeLoanDetails?.loanNo !=  "")
                                )?
                                DashboardLoanDetails(activeLoanDetails: dashBoarddataModel?.data!.activeLoanDetails):
                                SizedBox.shrink(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: FontConstants.horizontalPadding),
                                      child: Text(
                                        "We Provide",
                                        style: TextStyle(
                                          fontSize: FontConstants.f18,
                                          fontWeight: FontConstants.w800,
                                          fontFamily: FontConstants.fontFamily,
                                          color: ColorConstant.blackTextColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                                      child: SizedBox(
                                        height: 150,
                                        child: PageView.builder(
                                          controller: _controller,
                                          itemCount: dashBoarddataModel?.data?.appBanners?.length ?? 0,
                                          padEnds: false,
                                          itemBuilder: (context, index) {
                                            final item = dashBoarddataModel?.data?.appBanners?[index];
                                            return ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: Image.network(
                                                item?.imgUrl ?? "",
                                                height: 150,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return const Center(child: CircularProgressIndicator());
                                                },
                                                errorBuilder: (context, error, stackTrace) =>
                                                const Center(child: Icon(Icons.broken_image)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Center(
                                      child: SmoothPageIndicator(
                                        controller: _controller,
                                        count: dashBoarddataModel?.data?.appBanners?.length ?? 0,
                                        effect: const WormEffect(
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          spacing: 8,
                                          dotColor: Colors.grey,
                                          activeDotColor: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              );
            }
            else{
              return commonScaffold(
                  context,
                  bodyPart: SizedBox.expand(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            ImageConstants.permissionScreenBackground,
                            fit: BoxFit.cover, // Optional: to scale and crop nicely
                          ),
                        ),
                      ],
                    ),
                  )
              );
            }
          }
      ),
    );
  }

  Widget commonScaffold(BuildContext context,{required Widget bodyPart,dashBoardModel}){
    return Scaffold(
      body: bodyPart,
    );
  }

  Widget personalLoanApplyWidget(BuildContext context,DashBoarddataModel dashBoardModel){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstants.permissionScreenLeftPyramid,width: 26,height: 13),
            SizedBox(
              width: 214,
            ),
            Image.asset(ImageConstants.permissionScreenRightPyramid,width: 26,height: 13.0),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            //vertical: 32,
          ),
          padding: const EdgeInsets.all(FontConstants.horizontalPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 20),
              // other content goes here
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dashBoardModel.data?.applyLoanBanner?.appBannerText?? "",
                      //"Discover the possibilities with an instant personal loan up to Rs 1.2 Lakh. Curious about your eligibility? There's only one way to find out",
                      style: TextStyle(
                          fontWeight: FontConstants.w600,
                          fontSize: FontConstants.f14,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.greyTextColor
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  CircularProgressWithText(
                    progress: (dashBoardModel.data?.applyLoanBanner?.appBannerProgressPercent ?? 0) / 100,
                    isDrawer: false,
                  )
                ],
              ),
              SizedBox(height: 24.0),
            ],
          ),
        )
      ],
    );
  }
}







