import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Model/DashBoarddataModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Widget/circular_progress.dart';

class Loan112Drawer extends StatelessWidget {
  final DashBoarddataModel? dashBoarddataModel;
  const Loan112Drawer({super.key,this.dashBoarddataModel});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ColorConstant.appScreenBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          color: ColorConstant.drawerHeaderColor, // top 70px color
                        ),
                        Container(
                          height: 80,
                          color: ColorConstant.appScreenBackgroundColor, // bottom 70px color
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(FontConstants.horizontalPadding),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircularProgressWithText(
                                  progress: (dashBoarddataModel?.data?.applyLoanBanner?.appBannerProgressPercent ?? 0) / 100,
                                  isDrawer: true,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      dashBoarddataModel?.data?.fullName ?? "",
                                      //"SHIVANI",
                                      style: TextStyle(
                                          fontFamily: FontConstants.fontFamily,
                                          fontSize: FontConstants.f18,
                                          fontWeight: FontConstants.w800,
                                          color: ColorConstant.blackTextColor
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      dashBoarddataModel?.data?.mobile ?? "",
                                      //"9090000888",
                                      style: TextStyle(
                                          fontWeight: FontConstants.w600,
                                          fontSize: FontConstants.f12,
                                          fontFamily: FontConstants.fontFamily,
                                          color: ColorConstant.blackTextColor
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.0,top: 10.0),
                              child: Text(
                                "${dashBoarddataModel?.data?.applyLoanBanner!.appBannerProgressPercent?? 0.toString()}%",
                                //"${(0.5 * 100).toInt()}%",
                                style: TextStyle(
                                    fontFamily: FontConstants.fontFamily,
                                    fontWeight: FontConstants.w800,
                                    fontSize: FontConstants.f14,
                                    color: ColorConstant.blueTextColor
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                height: 1.0,
                color: ColorConstant.greyTextColor.withOpacity(0.5), // 50% opacity
              ),
              SizedBox(
                height: 24.0,
              ),

              // Menu items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMenuItem(ImageConstants.homeIcon, "Home",
                       onClick: (){
                         // DebugPrint.prt("Home Icon Pressed");
                         context.pop();
                       }
                    ),
                    _buildMenuItem(ImageConstants.drawerFaq, "FAQs",
                      onClick: (){
                        DebugPrint.prt("FAQ Icon Pressed");
                      }
                    ),
                    _buildMenuItem(ImageConstants.dashBoardHeadphone, "Support",
                      onClick: (){
                        DebugPrint.prt("Support Icon Pressed");
                      }
                    ),
                    _buildMenuItem(ImageConstants.drawerShareApp, "Share App",
                      onClick: (){
                        DebugPrint.prt("Share Icon Pressed");
                        SharePlus.instance.share(
                            ShareParams(text: 'Hey, I found this cool app: https://play.google.com/store/apps/details?id=com.personalLoan.loan112')
                        );
                      }
                    ),
                    _buildMenuItem(ImageConstants.drawerRateUs, "Rate Us",
                        onClick: (){
                          DebugPrint.prt("Rate Us Pressed");
                          openPlayStore(context);
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: FontConstants.horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap:() async{
                       var logOutData = await MySharedPreferences.logOutFunctionData();
                       if(logOutData){
                         context.go(AppRouterName.login);
                       }
                      },
                      child: SvgPicture.asset(
                        ImageConstants.drawerPower,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              const Divider(),
              // Delete Account
              Padding(
                padding: EdgeInsets.only(left: FontConstants.horizontalPadding,top: 10.0),
                child: Row(
                  children: [
                    Image.asset(ImageConstants.drawerDelete,height: 20,width: 20),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                          fontFamily: FontConstants.fontFamily,
                          fontWeight: FontConstants.w600,
                          fontSize: FontConstants.f14,
                          color: ColorConstant.errorRedColor
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              // Version
               Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Version : 19/2.2.4",
                  style: TextStyle(
                      fontSize: FontConstants.f14,
                      fontWeight: FontConstants.w600,
                      fontFamily: FontConstants.fontFamily,
                      color: ColorConstant.greyTextColor
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future<void> openPlayStore(BuildContext context) async {
    final Uri playStoreUrl = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.personalLoan.loan112&hl=en_IN&pli=1',
    );

    if (!await launchUrl(
      playStoreUrl,
      mode: LaunchMode.externalApplication,
    )) {
       openSnackBar(context, 'Could not launch $playStoreUrl');
    }
  }


  Widget _buildMenuItem(String icon, String title,{onClick}) {
    return ListTile(
      leading: Image.asset(icon, color: ColorConstant.greyTextColor,height: 20,width: 20),
      title: Text(
          title,
         style: TextStyle(
           fontFamily: FontConstants.fontFamily,
           fontSize: FontConstants.f14,
           fontWeight: FontConstants.w600,
           color: ColorConstant.blueTextColor
         ),
      ),
      trailing: const Icon(Icons.arrow_forward, size: 16),
      onTap: onClick,
    );
  }
}


