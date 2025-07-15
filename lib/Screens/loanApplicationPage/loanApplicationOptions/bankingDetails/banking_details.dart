import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Widget/app_bar.dart';
import '../../../../Widget/common_screen_background.dart';

class BankingDetailScreen extends StatefulWidget{
  const BankingDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BankingDetailScreen();
}

class _BankingDetailScreen extends State<BankingDetailScreen>{


  TextEditingController ifscCode = TextEditingController();

  var items = [
    "Saving",
    "Current"
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: GradientBackground(
        child: SafeArea(
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
                            "Banking Details",
                            style: TextStyle(
                                fontSize: FontConstants.f20,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w800,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Please enter your Bank details for Disbursal",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w600,
                                color: Color(0xff4E4F50)
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "IFSC Code*",
                            style: TextStyle(
                              fontSize: FontConstants.f14,
                              fontFamily: FontConstants.fontFamily,
                              fontWeight: FontConstants.w500,
                              color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: ifscCode,
                              hintText: "Enter your IFSC Code*"
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Bank A/C No*",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: ifscCode,
                              hintText: "Enter your Bank A/C No*"
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Confirm A/C No.*",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: ifscCode,
                              hintText: "Re-enter your Bank A/C No."
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Bank Name*",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: ifscCode,
                              hintText: "Enter your Bank Name*"
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Bank A/C Type*",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          bankAccountType(context)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              Loan112Button(text: "Submit",onPressed: (){}),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget bankAccountType(BuildContext context){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint:  Text(
          'Select Bank A/C Type*',
          style: TextStyle(
              fontSize: FontConstants.f14,
              color: ColorConstant.blackTextColor,
              fontWeight: FontConstants.w400,
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
          padding: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorConstant.textFieldBorderColor,
            ),
            color: ColorConstant.appScreenBackgroundColor,
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



}

