import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Widget/app_bar.dart';

class SelfieUploadedPage extends StatefulWidget{
  final String imagePath;
  const SelfieUploadedPage({super.key,required this.imagePath});

  @override
  State<StatefulWidget> createState() => _SelfieUploadedPage();
}

class _SelfieUploadedPage extends State<SelfieUploadedPage>{





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
                              "Selfie Uploaded",
                              style: TextStyle(
                                  fontSize: FontConstants.f20,
                                  fontWeight: FontConstants.w800,
                                  fontFamily: FontConstants.fontFamily,
                                  color: ColorConstant.blackTextColor
                              ),
                            ),
                            SizedBox(
                              height: 63,
                            ),
                            Center(
                              child: Container(
                                height: 245,
                                width: 245,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    image: DecorationImage(
                                        image: FileImage(File(widget.imagePath)),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 43,
                            ),
                            Center(
                              child: InkWell(
                                onTap: (){
                                  context.replace(AppRouterName.selfieScreenPath);
                                },
                                child: Text(
                                  "RECAPTURE",
                                  style: TextStyle(
                                      fontSize: FontConstants.f18,
                                      fontWeight: FontConstants.w700,
                                      fontFamily: FontConstants.fontFamily,
                                      color: ColorConstant.appThemeColor
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  color: ColorConstant.dashboardTextColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: FontConstants.f14,
                                      fontWeight: FontConstants.w700,
                                      fontFamily: FontConstants.fontFamily,
                                      color: ColorConstant.blackTextColor
                                    ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  color: ColorConstant.dashboardTextColor,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Loan112Button(onPressed: (){}, text: "CONTINUE")
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
    );
  }


}

