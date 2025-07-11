import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';

class AadharKycScreen extends StatefulWidget{
  const AadharKycScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AadharKycScreen();
}

class _AadharKycScreen extends State<AadharKycScreen>{

  TextEditingController adarOTPController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                Expanded(
                  child: SingleChildScrollView(
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
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: (50 * 4) + (12 * 3)), // total width
                              child: PinCodeTextField(
                                appContext: context,
                                length: 4,
                                controller: adarOTPController,
                                onChanged: (value) {},
                                keyboardType: TextInputType.number,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeColor: Colors.grey.shade400,
                                  inactiveColor: Colors.grey.shade300,
                                  selectedColor: Colors.blue.shade400,
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                cursorColor: Colors.blue,
                                animationType: AnimationType.fade,
                                enableActiveFill: true,
                                onCompleted: (otp) {
                                  // This is called when all 4 digits are entered
                                  debugPrint("OTP entered: $otp");
                                },
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // << key
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: Image.asset(ImageConstants.digiLockerIcon,width: 150,height: 36),
                          ),
                          SizedBox(
                            height: 45,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Column(
          children: [
            Divider(
              height: 8,
              color: ColorConstant.greyTextColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FontConstants.horizontalPadding,
                vertical: 24.0
              ),
              child: Column(
                children: [
                  Loan112Button(
                      onPressed: (){
                        context.push(AppRouterName.eKycMessageScreen);
                      },
                      text: "Get Started"
                  ),
                  SizedBox(
                    height: 23.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Need  Help..?",
                          style: TextStyle(
                            color: Color(0xff2B3C74),
                            fontSize: FontConstants.f14,
                            fontWeight: FontConstants.w600,
                            fontFamily: FontConstants.fontFamily
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "contact us",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: FontConstants.f14,
                              fontWeight: FontConstants.w600,
                              fontFamily: FontConstants.fontFamily
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

