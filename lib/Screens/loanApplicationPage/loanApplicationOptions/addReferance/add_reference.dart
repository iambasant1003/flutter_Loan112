import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_screen_background.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Widget/app_bar.dart';

class AddReferenceScreen extends StatefulWidget{
  const AddReferenceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddReferenceScreen();
}

class _AddReferenceScreen extends State<AddReferenceScreen>{


  TextEditingController referAnceNameController = TextEditingController();
  TextEditingController referAnceNumberController = TextEditingController();
  TextEditingController referAnceNameControllerTwo = TextEditingController();
  TextEditingController referAnceNumberControllerTwo = TextEditingController();

  final List<String> items = [
    'Father',
    'Mother',
    'Brother',
    'Friends',
    'Other'
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
                            "Add References",
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
                            "Note*  Only Two reference allowed",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontWeight: FontConstants.w500,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            "Reference Name",
                            style: TextStyle(
                              fontSize: FontConstants.f14,
                              fontWeight: FontConstants.w600,
                              fontFamily: FontConstants.fontFamily,
                              color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: referAnceNameController,
                              hintText: "Enter your Reference Name"
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Relation",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontWeight: FontConstants.w600,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          selectRelationType(context),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Mobile No.",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontWeight: FontConstants.w600,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          CommonTextField(
                              controller: referAnceNumberController,
                              hintText: "Enter mobile number"
                          ),
                          SizedBox(
                            height: 56,
                          ),
                          Center(
                            child: addMoreReferenceUI(context),
                          )
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
        child: Column(
          children: [
            Image.asset(ImageConstants.bottomDashLine),
            Padding(
              padding: EdgeInsets.only(bottom: 22,left: 16,right: 16,top: 10),
              child: Loan112Button(text: "CONTINUE"),
            )
          ],
        ),
      ),
    );
  }


  Widget selectRelationType(BuildContext context){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint:  Text(
          'Select Relation',
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

  Widget addMoreReferenceUI(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.appThemeColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        '+ Add one more reference',
        style: TextStyle(
          color: ColorConstant.whiteColor,
          fontSize: FontConstants.f14,
          fontWeight: FontConstants.w700,
          fontFamily: FontConstants.fontFamily
        ),
      ),
    );
  }


}

