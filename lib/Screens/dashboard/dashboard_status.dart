import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Screens/dashboard/dashboard_statusPage_Step.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';

import '../../Constant/FontConstant/FontConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';

class DashboardStatusScreen extends StatefulWidget {
  const DashboardStatusScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardStatusScreen();
}

class _DashboardStatusScreen extends State<DashboardStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Loan112AppBar(
        customLeading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorConstant.blackTextColor,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageConstants.permissionScreenBackground,
                fit: BoxFit.cover, // Optional: to scale and crop nicely
              ),
            ),

            //Positioned Data
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 37),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        personalLoanApplyWidget(context),
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
                                  "Status of Application",
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: FontConstants.horizontalPadding,
            ),
            child: Loan112Button(text: "Refresh", onPressed: () {}),
          ),
        ),
      ),
    );
  }

  Widget personalLoanApplyWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstants.permissionScreenLeftPyramid,
              width: 26,
              height: 13,
            ),
            SizedBox(width: 214),
            Image.asset(
              ImageConstants.permissionScreenRightPyramid,
              width: 26,
              height: 13.0,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
              SizedBox(height: 30),
              DashboardStatuspageStep(currentStep: 2),
            ],
          ),
        ),
      ],
    );
  }
}
