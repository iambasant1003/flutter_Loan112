import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';

class AadharKycScreen extends StatefulWidget{
  const AadharKycScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AadharKycScreen();
}

class _AadharKycScreen extends State<AadharKycScreen>{


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImageConstants.logInScreenBackGround,
            fit: BoxFit.cover,
          ),
        ),

        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Loan112AppBar(
                customLeading: InkWell(
                  child: Icon(Icons.arrow_back_ios,color: ColorConstant.blackTextColor),
                  onTap: (){
                    context.pop();
                  },
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "AADHAAR E-KYC",
                        style: TextStyle(
                          fontSize: FontConstants.f20,
                          fontWeight: FontConstants.w800,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.blackTextColor
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Experience seamless authentication with advanced eKYC technology! Simply enter the last 4 digits of your Aadhaar—no need to share the full number.",
                        style: TextStyle(
                          fontSize: FontConstants.f14,
                          fontWeight: FontConstants.w500,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.dashboardTextColor
                        ),
                      ),
                      SizedBox(
                        height: 56,
                      ),
                      Center(
                        child: Image.asset(
                          ImageConstants.adarIcon,
                          width: 220,
                          height: 141,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500
                            ), // default style
                            children: [
                              TextSpan(
                                text: 'Enter last 4 digit of your ',
                                style: TextStyle(color: ColorConstant.dashboardTextColor),
                              ),
                              TextSpan(
                                text: 'aadhaar',
                                style: TextStyle(color: ColorConstant.errorRedColor, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' number',
                                style: TextStyle(color: ColorConstant.dashboardTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

}