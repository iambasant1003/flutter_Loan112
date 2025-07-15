import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Widget/app_bar.dart';

class LoanOfferScreen extends StatefulWidget{
  const LoanOfferScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoanOfferScreen();
}

class _LoanOfferScreen extends State<LoanOfferScreen>{



  double currentValue = 0;
  final double maxValue = 40000;

  double currentTenure = 7;
  final double maxTenure = 40;

  final List<String> items = [
    'Home Loan',
    'Car Loan',
    'Personal Loan',
    'Education Loan',
  ];

  String? selectedValue;

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
        body: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  ImageConstants.permissionScreenBackground,
                  fit: BoxFit.cover, // Optional: to scale and crop nicely
                ),
              ),
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
            ],
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
                        // handle reject
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
                        onPressed: () {},
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


  Widget loanOfferContainer(BuildContext context){
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
                    "Based on your provided details, we’ve calculated your loan eligibility. Select your preferred loan amount and tenure to proceed.",
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
                         purposeOfLoanButton(context),
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
                         tenureSliderAndValue(context),
                       ],
                     ),
                   ),
                 ),
                  SizedBox(
                    height: 16.0,
                  ),
                  interestAndProcessingFeeUi(context),
                  SizedBox(
                    height: 16,
                  ),
                  totalLoanAmountUi(context),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Thank you for expressing your interest in Loan112 and providing us with an opportunity to assist you. Please proceed with the loan details above to continue.",
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
  }

  
  Widget purposeOfLoanButton(BuildContext context){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint:  Text(
          'Select Purpose of Loan*',
          style: TextStyle(
            fontSize: FontConstants.f14,
            color: ColorConstant.blackTextColor,
            fontWeight: FontConstants.w500,
            fontFamily: FontConstants.fontFamily
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style:  TextStyle(
              fontSize: FontConstants.f14,
              color: ColorConstant.blackTextColor,
                fontWeight: FontConstants.w500,
                fontFamily: FontConstants.fontFamily
            ),
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding:  EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorConstant.textFieldBorderColor,
            ),
            color: ColorConstant.whiteColor,
          ),
          elevation: 0,
        ),
        iconStyleData:  IconStyleData(
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
              setState(() {
                currentValue = value;
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

  Widget tenureSliderAndValue(BuildContext context){
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

  Widget interestAndProcessingFeeUi(BuildContext context){
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
        totalAmountUI(context,amountType: "Principal",amountValue: 5000),
        SizedBox(
          width: 10,
        ),
        totalAmountUI(context,amountType: "Interest",amountValue: 350),
        SizedBox(
          width: 10,
        ),
        totalAmountUI(context,amountType: "Total Payable",amountValue: 5350)
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










