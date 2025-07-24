import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/Model/GenerateLoanOfferModel.dart';
import 'package:loan112_app/Model/GetPurposeOfLoanModel.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Model/VerifyOTPModel.dart';
import '../../../../ParamModel/LoanAcceptanceParamModel.dart';
import '../../../../Utils/MysharePrefenceClass.dart';
import '../../../../Widget/app_bar.dart';

class LoanOfferScreen extends StatefulWidget{
  const LoanOfferScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoanOfferScreen();
}

class _LoanOfferScreen extends State<LoanOfferScreen>{



  double currentValue = 0;
  double maxValue = 40000;
  double currentTenure = 0;
  double maxTenure = 40;
  bool initialized = false;
  String? purPoseOfLoan;
  int interestRate = 0;
  String interestAmount = "";
  String totalPayableAmount = "";
  String purposeOfLoanId = "";
  // put this in your State
  DataModeL? selectedPurpose;
  GenerateLoanOfferModel? generateLoanOfferModel;
  GetPurposeOfLoanModel? getPurposeOfLoanModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateLoanOfferApiCall();
    });
  }



  generateLoanOfferApiCall() async{
    var otpModel = await MySharedPreferences.getUserSessionDataNode();
    VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));
    var leadId = verifyOtpModel.data?.leadId ?? "";
    if (leadId == "") {
      leadId = await MySharedPreferences.getLeadId();
    }
    context.read<LoanApplicationCubit>().getPurposeOfLoanApiCall(
      {
        "leadId": leadId
      }
    );
  }

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
          backgroundColor: Color(0xffE7F3FF),
        ),
        body: BlocListener<LoanApplicationCubit,LoanApplicationState>(
          listener: (context,state){
            if(state is LoanApplicationLoading){
              EasyLoading.show(status: "Please wait...");
            }else if(state is GenerateLoanOfferSuccess){
              EasyLoading.dismiss();
              DebugPrint.prt("Loan Offer Success Ui");
              generateLoanOfferModel = state.generateLoanOfferModel;
              getPurposeOfLoanModel = state.getPurposeOfLoanModel;
                currentTenure = double.parse((generateLoanOfferModel?.data!.minLoanTenure ?? 0).toString());
                maxTenure = double.parse((generateLoanOfferModel?.data!.maxLoanTenure ?? 0).toString());
                currentValue = double.parse((generateLoanOfferModel?.data!.minLoanAmount ?? 0).toString());
                maxValue = double.parse((generateLoanOfferModel?.data!.maxLoanAmount ?? 0).toString());
                interestRate = generateLoanOfferModel?.data!.interestRate ?? 0;

                DebugPrint.prt("Model data $generateLoanOfferModel, $getPurposeOfLoanModel");

                Future.delayed(const Duration(milliseconds: 500), () {
                  calculateLoan(principal: currentValue, tenure: currentTenure,
                      interestRate: double.parse((interestRate).toString())
                  );
                });
                setState(() {});
            }else if(state is GenerateLoanOfferError){
              EasyLoading.dismiss();
              openSnackBar(context, state.generateLoanOfferModel.message ?? "Unknown Error");
            }else if(state is GetPurposeOfLoanFailed){
              EasyLoading.dismiss();
              openSnackBar(context, state.getPurposeOfLoanModel.message ?? "Unknown Error");
            } else if(state is LoanAcceptanceLoading){
              EasyLoading.show(status: "Please wait...");
            } else if(state is LoanAcceptanceSuccess){
              EasyLoading.dismiss();
              context.pop();
            }else if(state is LoanAcceptanceError){
              EasyLoading.dismiss();
              openSnackBar(context, state.loanAcceptanceModel.message ?? "Unknown Error");
            }
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
                if(generateLoanOfferModel != null && getPurposeOfLoanModel != null)...[
              Positioned(
                left: 15,
                right: 15,
                top: 20,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    loanOfferContainer(context),
                    Positioned(
                      top: 0,
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
                              "Your Loan Offer",
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
                  ],
                ),
              )
            ]
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset(ImageConstants.bottomDashLine,height: 4),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 61
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        loanAcceptanceApiCall(context,2);
                      },
                      child: Text(
                        "REJECT",
                        style: TextStyle(
                          fontSize: FontConstants.f16,
                          fontFamily: FontConstants.fontFamily,
                          fontWeight: FontConstants.w700,
                          color: ColorConstant.brownColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 16), // optional spacing
                    SizedBox(
                      width: 150, // or any fixed width you want
                      child: Loan112Button(
                        text: "CONTINUE",
                        onPressed: () {
                          loanAcceptanceApiCall(context, 1);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }




  // {
  // "custId":"ZGIwZTNiYzQxMGM3YzE2MTM3Mzg3MTk2MjM0MGUxODY=",
  // "leadId":"NzM3NWY2YzAzOThiNTY2NGIzMzVhMzQ1NDk1NzJiMzg=",
  // "loanAmount":"",
  // "tenure":"",
  // "loanAcceptId":""
  // }

  void loanAcceptanceApiCall(BuildContext context,int loanAcceptedId) async{
     if(purposeOfLoanId != ""){
       var otpModel = await MySharedPreferences.getUserSessionDataNode();
       VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));
       var leadIdData = verifyOtpModel.data?.leadId;
       if(leadIdData == "" || leadIdData == null){
         leadIdData = await MySharedPreferences.getLeadId();
       }
       Loanacceptanceparammodel loanacceptanceparammodel = Loanacceptanceparammodel();
       loanacceptanceparammodel.custId = verifyOtpModel.data?.custId;
       loanacceptanceparammodel.leadId = leadIdData;
       loanacceptanceparammodel.loanAmount = currentValue.toInt();
       loanacceptanceparammodel.tenure = currentTenure.toInt();
       loanacceptanceparammodel.loanPurposeId = int.parse(purposeOfLoanId);
       loanacceptanceparammodel.loanAcceptId = loanAcceptedId;

       context.read<LoanApplicationCubit>().loanAcceptanceApiCall(loanacceptanceparammodel.toJson());
     }else{
       openSnackBar(context, "Please select purpose of loan");
     }
  }



  Widget loanOfferContainer(BuildContext context){
    return BlocBuilder<LoanApplicationCubit,LoanApplicationState>(
        builder: (context,state){
           if(generateLoanOfferModel != null && getPurposeOfLoanModel != null){
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
                   width: MediaQuery.of(context).size.width * 0.9,
                   height: MediaQuery.of(context).size.height * 0.9,
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: [
                         ColorConstant.whiteColor,
                         ColorConstant.appScreenBackgroundColor,
                       ],
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                     ),
                     borderRadius: const BorderRadius.all(
                       Radius.circular(10.0),
                     ),
                   ),
                   //padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                   child: SingleChildScrollView(
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           SizedBox(
                             height: 46,
                           ),
                           Text(
                             generateLoanOfferModel?.data?.loanQuotePageTopText ?? "",
                             textAlign: TextAlign.center,
                             //"Based on your provided details, we’ve calculated your loan eligibility. Select your preferred loan amount and tenure to proceed.",
                             style: TextStyle(
                                 fontSize: FontConstants.f14,
                                 fontWeight: FontConstants.w500,
                                 fontFamily: FontConstants.fontFamily,
                                 color: ColorConstant.dashboardTextColor
                             ),
                           ),
                           SizedBox(
                             height: 32,
                           ),
                           Container(
                             decoration: BoxDecoration(
                                 color: ColorConstant.containerBackground,
                                 borderRadius: BorderRadius.all(Radius.circular(16.0))
                             ),
                             child: Padding(
                               padding: EdgeInsets.symmetric(
                                   horizontal: 12.0,
                                   vertical: 12.0
                               ),
                               child: Column(
                                 children: [
                                   Center(
                                     child: Text(
                                       "Purpose of Loan*".toUpperCase(),
                                       style: TextStyle(
                                           fontSize: FontConstants.f16,
                                           fontWeight: FontConstants.w700,
                                           fontFamily: FontConstants.fontFamily,
                                           color: ColorConstant.blueTextColor
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 6.0,
                                   ),
                                   purposeOfLoanButton(context,getPurposeOfLoanModel!),
                                   SizedBox(
                                     height: 12.0,
                                   ),
                                   Center(
                                     child: Text(
                                       "PRINCIPAL",
                                       style: TextStyle(
                                           fontSize: FontConstants.f16,
                                           fontFamily: FontConstants.fontFamily,
                                           fontWeight: FontConstants.w700,
                                           color: ColorConstant.blueTextColor
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 15.0,
                                   ),
                                   principalSliderAndValue(context),
                                   SizedBox(
                                     height: 12.0,
                                   ),
                                   Center(
                                     child: Text(
                                       "TENURE",
                                       style: TextStyle(
                                           fontSize: FontConstants.f16,
                                           fontFamily: FontConstants.fontFamily,
                                           fontWeight: FontConstants.w700,
                                           color: ColorConstant.blueTextColor
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 15.0,
                                   ),
                                   tenureSliderAndValue(context,valueType:generateLoanOfferModel?.data?.loanTenureText??""),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(
                             height: 16.0,
                           ),
                           interestAndProcessingFeeUi(context,generateLoanOfferModel: generateLoanOfferModel),
                           SizedBox(
                             height: 16,
                           ),
                           totalLoanAmountUi(context),
                           SizedBox(
                             height: 16,
                           ),
                           Text(
                             generateLoanOfferModel?.data?.loanQuotePageBottomText ?? "",
                             // "Thank you for expressing your interest in Loan112 and providing us with an opportunity to assist you. Please proceed with the loan details above to continue.",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                                 fontSize: FontConstants.f12,
                                 fontWeight: FontConstants.w500,
                                 fontFamily: FontConstants.fontFamily,
                                 color: ColorConstant.brownColor
                             ),
                           ),
                           SizedBox(
                             height: 150.0,
                           )
                         ],
                       ),
                     ),
                   ),
                 )
               ],
             );
           }else{
             return Column(
               children: [

               ],
             );
           }
        }
    );
  }




  Widget purposeOfLoanButton(BuildContext context, GetPurposeOfLoanModel getPurposeOfLoanModel) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<DataModeL>(
        isExpanded: true,
        hint: Text(
          'Select Purpose of Loan*',
          style: TextStyle(
            fontSize: FontConstants.f14,
            color: ColorConstant.blackTextColor,
            fontWeight: FontConstants.w500,
            fontFamily: FontConstants.fontFamily,
          ),
        ),
        items: getPurposeOfLoanModel.data!
            .map((item) => DropdownMenuItem<DataModeL>(
          value: item,
          child: Text(
            item.loanPurposeName ?? "",
            style: TextStyle(
              fontSize: FontConstants.f14,
              color: ColorConstant.blackTextColor,
              fontWeight: FontConstants.w500,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
        ))
            .toList(),
        value: selectedPurpose,
        onChanged: (value) {
          setState(() {
            selectedPurpose = value;
            purposeOfLoanId = value?.loanPurposeId ?? "";
          });

          DebugPrint.prt("Loan Purpose Id $purposeOfLoanId");
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorConstant.textFieldBorderColor,
            ),
            color: ColorConstant.whiteColor,
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: ColorConstant.greyTextColor,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }


  Widget principalSliderAndValue(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.blue.shade100,
            thumbColor: ColorConstant.blackTextColor,
            overlayColor: Colors.blue.withOpacity(0.2),
            thumbShape: CustomThumbShape(),
            trackHeight: 4,
          ),
          child: Slider(
            value: currentValue,
            min: 0,
            max: maxValue,
            divisions: 8,
            onChanged: (value) {
              DebugPrint.prt("Current Principal Amount $value");
              setState(() {
                currentValue = value;
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                calculateLoan(principal: currentValue, tenure: currentTenure,
                    interestRate: double.parse((interestRate).toString())
                );
              });
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rs. ${currentValue.toInt()}',
              style: TextStyle(
                fontSize: FontConstants.f14,
                fontWeight: FontConstants.w600,
                fontFamily: FontConstants.fontFamily,
                color: ColorConstant.blackTextColor
              ),
            ),
            Text(
              'Max Rs. ${maxValue.toInt()}',
              style: TextStyle(
                fontSize: FontConstants.f14,
                fontWeight: FontConstants.w600,
                fontFamily: FontConstants.fontFamily,
                color: ColorConstant.brownColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tenureSliderAndValue(BuildContext context,{valueType = "Days"}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.blue.shade100,
            thumbColor: ColorConstant.blackTextColor,
            overlayColor: Colors.blue.withOpacity(0.2),
            thumbShape: CustomThumbShape(),
            trackHeight: 4,
          ),
          child: Slider(
            value: currentTenure,
            min: 0,
            max: maxTenure,
            divisions: 8,
            onChanged: (value) {
              setState(() {
                currentTenure = value;
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                calculateLoan(principal: currentValue, tenure: currentTenure,
                    interestRate: double.parse((interestRate).toString())
                );
              });
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${currentTenure.toInt()} Days',
              style: TextStyle(
                  fontSize: FontConstants.f14,
                  fontWeight: FontConstants.w600,
                  fontFamily: FontConstants.fontFamily,
                  color: ColorConstant.blackTextColor
              ),
            ),
            Text(
              'Max ${maxTenure.toInt()} Days',
              style: TextStyle(
                fontSize: FontConstants.f14,
                fontWeight: FontConstants.w600,
                fontFamily: FontConstants.fontFamily,
                color: ColorConstant.brownColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget interestAndProcessingFeeUi(BuildContext context,{GenerateLoanOfferModel? generateLoanOfferModel}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.containerBackground,
                borderRadius: BorderRadius.all(Radius.circular(6.0))
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FontConstants.horizontalPadding,
                  vertical: FontConstants.horizontalPadding
              ),
              child: Column(
                children: [
                  Image.asset(ImageConstants.interestIcon,height: 24,width: 24),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    generateLoanOfferModel?.data?.interestRateText ??
                    "Interest 1.00% p.d.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FontConstants.f14,
                        fontWeight: FontConstants.w600,
                        fontFamily: FontConstants.fontFamily,
                        color: ColorConstant.dashboardTextColor
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.containerBackground,
                borderRadius: BorderRadius.all(Radius.circular(6.0))
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: FontConstants.horizontalPadding,
                  vertical: FontConstants.horizontalPadding
              ),
              child: Column(
                children: [
                  Image.asset(ImageConstants.lonProcessIcon,height: 24,width: 24),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    generateLoanOfferModel?.data?.processingFeeText ??
                    "Processing Fee 10%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FontConstants.f14,
                        fontWeight: FontConstants.w600,
                        fontFamily: FontConstants.fontFamily,
                        color: ColorConstant.dashboardTextColor
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget totalLoanAmountUi(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        totalAmountUI(context,amountType: "Principal",
            amountValue: (currentValue % 1 == 0)
                ? currentValue.toInt().toString()
                : currentValue.toStringAsFixed(2)
        ),
        SizedBox(
          width: 10,
        ),
        totalAmountUI(context,amountType: "Interest",amountValue: interestAmount),
        SizedBox(
          width: 10,
        ),
        totalAmountUI(context,amountType: "Total Payable",amountValue: totalPayableAmount)
      ],
    );
  }

  Widget totalAmountUI(BuildContext context,{amountType,amountValue}){
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 100,
      decoration: BoxDecoration(
          color: ColorConstant.containerBackground,
          borderRadius: BorderRadius.all(Radius.circular(6.0))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0,
            //FontConstants.horizontalPadding,
            vertical: FontConstants.horizontalPadding
        ),
        child: Column(
          children: [
            Text(
              amountType ?? "",
              style: TextStyle(
                fontSize: FontConstants.f12,
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontConstants.w600,
                color: ColorConstant.dashboardTextColor
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              amountValue == null ? "":
              "Rs.$amountValue",
              style: TextStyle(
                  fontSize: FontConstants.f14,
                  fontWeight: FontConstants.w700,
                  fontFamily: FontConstants.fontFamily,
                  color: ColorConstant.blueTextColor
              ),
            )
          ],
        ),
      ),
    );
  }


  calculateLoan({
    required double principal,
    required double tenure,
    required double interestRate,
  }) {
    double interest = principal * (interestRate / 100) * tenure;
    double totalPayable = principal + interest;
    setState(() {
      interestAmount = (interest % 1 == 0)
          ? interest.toInt().toString()
          : interest.toStringAsFixed(2);

      totalPayableAmount = (totalPayable % 1 == 0)
          ? totalPayable.toInt().toString()
          : totalPayable.toStringAsFixed(2);
    });
  }

}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30, 30);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // Outer circle with light blue border & white fill
    final Paint outerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 12, outerPaint);
    canvas.drawCircle(center, 12, borderPaint);

    // Inner dot (dark blue)
    final Paint innerDotPaint = Paint()
      ..color = Colors.blue[800]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5, innerDotPaint);
  }
}

// LoanAcceptedId Value
// 1- Accept
//2- Reject
//3 - Enhancement





