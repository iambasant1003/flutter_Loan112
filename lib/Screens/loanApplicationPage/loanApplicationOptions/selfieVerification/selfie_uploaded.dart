import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ConstText/ConstText.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Cubit/loan_application_cubit/LoanApplicationState.dart';
import '../../../../Model/VerifyOTPModel.dart';
import '../../../../Utils/MysharePrefenceClass.dart';
import '../../../../Widget/app_bar.dart';
import 'package:image/image.dart' as img;

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
      body: BlocListener<LoanApplicationCubit,LoanApplicationState>(
        listenWhen: (prev,current){
          return prev != current;
        },
        listener: (context,state){
          if(state is LoanApplicationLoading){
            EasyLoading.show(status: "Please Wait...");
          }else if(state is UploadSelfieSuccess){
            EasyLoading.dismiss();
            openSnackBar(context, state.uploadSelfieModel.message ?? "Selfie uploaded successFully");
            context.pop();
          }else if(state is UploadSelfieError){
            EasyLoading.dismiss();
            openSnackBar(context, state.uploadSelfieModel.message ?? "Unknown Error");
          }
        },
        child: Stack(
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
                              Loan112Button(onPressed: () async{
                                var imagePathConverted = await convertToJpeg(widget.imagePath);
                                DebugPrint.prt("Image Path ${imagePathConverted.path}");
                                var otpModel = await MySharedPreferences.getUserSessionDataNode();
                                VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));

                                final Map<String, dynamic> dataObj = {
                                  'custId': verifyOtpModel.data?.custId,
                                  'leadId': verifyOtpModel.data?.leadId,
                                  'requestSource': ConstText.requestSource,
                                  'selfie': await MultipartFile.fromFile(
                                    imagePathConverted.path,
                                    filename: imagePathConverted.path.split('/').last,
                                  ),
                                };
                                context.read<LoanApplicationCubit>().uploadSelfieApiCall(dataObj);
                              }, text: "CONTINUE")
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
      ),
    );
  }




  Future<File> convertToJpeg(String inputPath, {int quality = 90}) async {
    final file = File(inputPath);

    // Read the original image
    final bytes = await file.readAsBytes();
    final originalImage = img.decodeImage(bytes);

    if (originalImage == null) {
      throw Exception("Failed to decode image");
    }

    // Encode as JPEG
    final jpegBytes = img.encodeJpg(originalImage, quality: quality);

    // Save to a new file
    final outputPath = inputPath.replaceAll(RegExp(r'\.\w+$'), '.jpeg');
    final outputFile = File(outputPath);
    await outputFile.writeAsBytes(jpegBytes);

    return outputFile;
  }


}

