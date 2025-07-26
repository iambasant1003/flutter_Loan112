

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
import '../../Widget/app_bar.dart';
import '../../Widget/circular_progress.dart';
import '../../Widget/common_button.dart';
import '../drawer/drawer_page.dart';

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

  final PageController _controller = PageController();

  List<String> imageData = ["Ram","Shyam"];


  DashBoarddataModel? dashBoarddataModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit,DashboardState>(
      listenWhen: (prev,next){
        return prev != next;
      },
      listener: (context,state){
        if(state is DashBoardLoading){
          DebugPrint.prt('DashBoard Is Loading');
          EasyLoading.show(status: "Please Wait");
        }else if(state is DashBoardSuccess){
          EasyLoading.dismiss();
        }else if(state is DashBoardError){
          DebugPrint.prt("DashBoard Is facing Error");
          EasyLoading.dismiss();
          openSnackBar(context, state.dashBoardModel.message ?? "Unknown Error");
        }else if(state is DeleteCustomerSuccess){
          EasyLoading.dismiss();
          context.push(AppRouterName.dashBoardOTP);
        }else if(state is DeleteCustomerFailed){
          EasyLoading.dismiss();
          openSnackBar(context, state.deleteCustomerModel.message ?? "Unexpected Error");
        }
      },
      child: BlocBuilder<DashboardCubit,DashboardState>(
          builder: (context,state){
            if(state is DashBoardSuccess){
              dashBoarddataModel = state.dashBoardModel;
            }
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
                                            if(dashBoarddataModel?.data?.applicationSubmitted == 1){
                                              context.push(AppRouterName.dashBoardStatus);
                                            }else{
                                              context.push(AppRouterName.loanApplicationPage);
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
                                // DashboardLoanDetails(),
                                Padding(
                                  padding: EdgeInsets.only(left: FontConstants.horizontalPadding),
                                  child: Text(
                                    "We Provide",
                                    style: TextStyle(
                                        fontSize: FontConstants.f18,
                                        fontWeight: FontConstants.w800,
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorConstant.blackTextColor
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 220,
                                  child: PageView.builder(
                                    controller: _controller,
                                    itemCount: dashBoarddataModel?.data?.appBanners?.length,
                                    itemBuilder: (context, index) {
                                      final item = dashBoarddataModel?.data?.appBanners?[index];
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                                          child: Image.network(item?.imgUrl ??"" ,height: 156)
                                        /*
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(item?.imgUrl ??"" ),
                                            fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                          )
                                        ],
                                      ),
                                      // child: Image.asset(ImageConstants.emergencyLoanPoster)
                                    ),

                                         */
                                      );
                                    },
                                  ),
                                ),
                                Center(
                                  child: SmoothPageIndicator(
                                    controller: _controller,
                                    count: dashBoarddataModel?.data?.appBanners!.length ?? 0,
                                    effect: const WormEffect(
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      spacing: 8,
                                      dotColor: Colors.grey,
                                      activeDotColor: Colors.blue,
                                    ),
                                  ),
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






