import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';

class CheckEligibility extends StatefulWidget{
  const CheckEligibility({super.key});

  @override
  State<StatefulWidget> createState() => _CheckEligibility();
}

class _CheckEligibility extends State<CheckEligibility>{



  String employmentType = "Salaried";
  String modeOfIncome = "Bank";

  TextEditingController netMonthlyIncome = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background image
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
                    onTap: (){
                      context.pop();
                    },
                    child: Icon(Icons.arrow_back_ios, color: ColorConstant.blackTextColor),
                  ),
                ),
                SizedBox(height: 8.0),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check Your Eligibility",
                        style: TextStyle(
                          fontSize: FontConstants.f20,
                          fontWeight: FontConstants.w800,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.blackTextColor,
                        ),
                      ),
                      SizedBox(height: 16.0),

                      Text(
                        "Ensure to provide correct information!",
                        style: TextStyle(
                          fontSize: FontConstants.f14,
                          fontWeight: FontConstants.w600,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.0),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.0),

                        labelTypeWidget("Select Employment Type"),
                        SizedBox(height: 24.0),

                        employmentTypeSelector(
                          selectedType: employmentType,
                          onChanged: (val) {
                            setState(() {
                              employmentType = val;
                            });
                          },
                        ),
                        SizedBox(height: 24.0),

                        labelTypeWidget("Net Monthly Income"),
                        SizedBox(height: 6.0),

                        CommonTextField(
                          controller: netMonthlyIncome,
                          hintText: "Enter your net monthly income*",
                        ),
                        SizedBox(height: 12.0),

                        labelTypeWidget("Mode of Income Received"),
                        SizedBox(height: 24.0),

                        modeOfIncomeTypeSelector(
                          selectedType: modeOfIncome,
                          onChanged: (val) {
                            setState(() {
                              modeOfIncome = val;
                            });
                          },
                        ),
                        SizedBox(height: 12.0),

                        labelTypeWidget("Date of Birth"),
                        SizedBox(height: 6.0),

                        CommonTextField(
                          controller: dateOfBirth,
                          hintText: "Select your Date of Birth*",
                          trailingWidget: Icon(Icons.calendar_month, color: ColorConstant.greyTextColor, size: 20),
                        ),
                        SizedBox(height: 12.0),

                        labelTypeWidget("Pin code"),
                        SizedBox(height: 6.0),

                        CommonTextField(
                          controller: pinCodeController,
                          hintText: "Enter Pin code",
                        ),
                        SizedBox(height: 12.0),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelTypeWidget("State"),
                                  SizedBox(height: 6.0),
                                  CommonTextField(
                                    controller: stateController,
                                    hintText: "Enter your State",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelTypeWidget("City"),
                                  SizedBox(height: 6.0),
                                  CommonTextField(
                                    controller: cityController,
                                    hintText: "Enter your City",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),

                        labelTypeWidget("PAN Number"),
                        SizedBox(height: 6.0),

                        CommonTextField(
                          controller: panController,
                          hintText: "Enter PAN Number",
                        ),
                        SizedBox(height: 12.0),

                        labelTypeWidget("Personal Email"),
                        SizedBox(height: 6.0),

                        CommonTextField(
                          controller: emailController,
                          hintText: "Enter your Email",
                        ),
                        SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 140,
        color: ColorConstant.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.0,
              ),
              Loan112Button(
                  onPressed: (){
                    context.push(AppRouterName.eligibilityStatus);
                  },
                  text: "Check Eligibility"
              ),
              SizedBox(
                height: 23,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Need  Help..?",
                    style: TextStyle(
                      fontFamily: FontConstants.fontFamily,
                      fontSize: FontConstants.f14,
                      fontWeight: FontConstants.w600,
                      color: ColorConstant.blackTextColor
                    ),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Text(
                    "contact us",
                    style: TextStyle(
                        fontFamily: FontConstants.fontFamily,
                        fontSize: FontConstants.f14,
                        fontWeight: FontConstants.w800,
                        color: ColorConstant.blackTextColor
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget labelTypeWidget(String label){
    return Text(
      label,
      style: TextStyle(
          fontSize: FontConstants.f14,
          fontWeight: FontConstants.w600,
          fontFamily: FontConstants.fontFamily,
          color: ColorConstant.blackTextColor
      ),
    );
  }

 
  Widget employmentTypeSelector({
    required String selectedType,
    required Function(String) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOption(
          label: 'Salaried',
          isSelected: selectedType == 'Salaried',
          onTap: () => onChanged('Salaried'),
        ),
        const SizedBox(width: 24),
        _buildOption(
          label: 'Self Employed',
          isSelected: selectedType == 'Self Employed',
          onTap: () => onChanged('Self Employed'),
        ),
      ],
    );
  }



  Widget modeOfIncomeTypeSelector({
    required String selectedType,
    required Function(String) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOption(
          label: 'Bank',
          isSelected: selectedType == 'Bank',
          onTap: () => onChanged('Bank'),
        ),
        const SizedBox(width: 24),
        _buildOption(
          label: 'Cheque',
          isSelected: selectedType == 'Cheque',
          onTap: () => onChanged('Cheque'),
        ),
        const SizedBox(width: 24),
        _buildOption(
          label: 'Cash',
          isSelected: selectedType == 'Cash',
          onTap: () => onChanged('Cash'),
        ),
      ],
    );
  }




  Widget _buildOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? ColorConstant.appThemeColor : ColorConstant.greyTextColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: ColorConstant.whiteColor,
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ColorConstant.appThemeColor : ColorConstant.greyTextColor,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.appThemeColor,
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: ColorConstant.blackTextColor,
                fontWeight: FontConstants.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }



}