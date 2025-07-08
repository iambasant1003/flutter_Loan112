import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import '../../Constant/FontConstant/FontConstant.dart';
import '../../Routes/app_router_name.dart';
import '../../Widget/common_button.dart';


class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<StatefulWidget> createState() => _PermissionPage();
}

class _PermissionPage extends State<PermissionPage> {
  bool allPermissionAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // background fills screen
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageConstants.permissionScreenBackground,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20), // avoid bottom cut-off
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        permissionContainerWidget(context),
                        const SizedBox(height: 60), // leave space for button
                      ],
                    ),
                    Positioned(
                      top: 15,
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
                              "Permissions",
                              style: TextStyle(
                                fontSize: FontConstants.f18,
                                fontWeight: FontConstants.w800,
                                color: ColorConstant.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: 162,
                          child: Loan112Button(
                            onPressed: () {
                              if (allPermissionAccepted) {
                                MySharedPreferences.setPermissionStatus(true);
                                context.push(AppRouterName.login);
                              }
                            },
                            text: "Allow",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget permissionTypeWidget(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.appThemeColor.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 4), // x: 0, y: 4 => shadow below only
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 35.0,
              right: 12.0,
              top: 12.0,
              bottom: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: FontConstants.f16,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w700,
                    color: ColorConstant.blackTextColor,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: FontConstants.fontFamily,
                          fontSize: FontConstants.f12,
                          fontWeight: FontConstants.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          bottom: 10,
          left: -4,
          child: Image.asset(imagePath, width: 46, height: 46),
        ),
      ],
    );
  }


  Widget permissionContainerWidget(BuildContext context){
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
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 28),
              // other content goes here
              permissionTypeWidget(
                context,
                title: 'Location',
                subtitle:
                'To begin, we need to know where you live to access servicing of products to you.',
                imagePath: ImageConstants.permissionScreenLocation,
              ),
              SizedBox(height: 12),
              permissionTypeWidget(
                context,
                title: 'Device',
                subtitle:
                'To collect your primary and social account information to verify your identify',
                imagePath: ImageConstants.permissionScreenDevice,
              ),
              SizedBox(height: 12),
              permissionTypeWidget(
                context,
                title: 'SMS',
                subtitle: 'To send and read sms for authentication',
                imagePath: ImageConstants.permissionScreenSMS,
              ),
              SizedBox(height: 12),
              permissionTypeWidget(
                context,
                title: 'Camera',
                subtitle:
                'Grant access so you can take some selfies for verification',
                imagePath: ImageConstants.permissionScreenCamera,
              ),
              SizedBox(height: 16.0),
              consentBoxUI(context),
              SizedBox(height: 24.0),
            ],
          ),
        )
      ],
    );
  }


  Widget consentBoxUI(BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: allPermissionAccepted,
          onChanged: (val) {
            setState(() {
              allPermissionAccepted = val!;
            });
          },
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'By proceeding, you agree to our ',
              style: TextStyle(
                color: ColorConstant.greyTextColor,
                fontSize: FontConstants.f12,
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontConstants.w500,
              ),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: TextStyle(
                    color: ColorConstant.blueTextColor,
                    fontSize: FontConstants.f12,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w500,
                  ),
                  recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Navigate to Terms & Conditions page
                      print(
                        'Terms & Conditions clicked',
                      );
                    },
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: ColorConstant.greyTextColor,
                    fontSize: FontConstants.f12,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w500,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: ColorConstant.blueTextColor,
                    fontSize: FontConstants.f12,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w500,
                  ),
                  recognizer:
                  TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Navigate to Privacy Policy page
                      print('Privacy Policy clicked');
                    },
                ),
                TextSpan(
                  text:
                  ' and consent to receive WhatsApp and email communications.',
                  style: TextStyle(
                    color: ColorConstant.greyTextColor,
                    fontSize: FontConstants.f12,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



}
