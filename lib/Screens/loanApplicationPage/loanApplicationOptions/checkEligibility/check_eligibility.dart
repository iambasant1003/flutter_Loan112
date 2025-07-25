import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loan112_app/Constant/ConstText/ConstText.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/Model/VerifyOTPModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Utils/UpperCaseTextFormatter.dart';
import '../../../../Utils/validation.dart';

class CheckEligibility extends StatefulWidget{
  const CheckEligibility({super.key});

  @override
  State<StatefulWidget> createState() => _CheckEligibility();
}

class _CheckEligibility extends State<CheckEligibility>{



  int employmentType = 1;
  int gender = 1;
  bool submitted = false;
  String stateId = "";
  String cityId = "";

  TextEditingController netMonthlyIncome = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    netMonthlyIncome.dispose();
    dateOfBirth.dispose();
    pinCodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    panController.dispose();
    emailController.dispose();
    companyNameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoanApplicationCubit,LoanApplicationState>(
        listener: (context, state) {
          if (state is LoanApplicationLoading) {
            EasyLoading.show(status: "Please Wait...");
          } else if (state is CreateLeadSuccess) {
            EasyLoading.dismiss();
            MySharedPreferences.setLeadId(state.createLeadModel.data?.leadId ?? "");

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              context.replace(AppRouterName.eligibilityStatus, extra: state.createLeadModel);
            });

          } else if (state is GetPinCodeDetailsSuccess) {
            EasyLoading.dismiss();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              stateController.text = state.pinCodeDetailsModel.data?.stateName ?? "";
              cityController.text = state.pinCodeDetailsModel.data?.cityName ?? "";
              stateId = state.pinCodeDetailsModel.data?.stateId.toString() ?? "";
              cityId = "110"; // You may want to avoid hardcoding this
            });

          } else if (state is CreateLeadError) {
            EasyLoading.dismiss();

            if (state.createLeadModel.message == "You are not eligible" &&
                state.createLeadModel.statusCode == 402 &&
                state.createLeadModel.success == false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;
                context.replace(AppRouterName.eligibilityStatus, extra: state.createLeadModel);
              });
            }

          } else if (state is LoanApplicationError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              openSnackBar(context, state.message);
            });
          }
        },
        child: Stack(
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
                        child: Form(
                          key: _formKey,
                          autovalidateMode: submitted?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.0),

                              labelTypeWidget("Select Employment Type"),
                              SizedBox(height: 6.0),

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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (val){
                                  if(val!.trim().isEmpty){
                                    return "Please enter your net monthly income";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12.0),
                              labelTypeWidget("Company Name"),
                              SizedBox(height: 6.0),

                              CommonTextField(
                                controller: companyNameController,
                                hintText: "Enter your Company Name*",
                                keyboardType: TextInputType.text,
                                validator: (val){
                                  if(val!.trim().isEmpty){
                                    return "Please enter your company name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12.0),

                              labelTypeWidget("Select Gender Type"),
                              SizedBox(height: 6.0),

                              modeOfIncomeTypeSelector(
                                selectedType: gender,
                                onChanged: (val) {
                                  setState(() {
                                    gender = val;
                                  });
                                },
                              ),

                              SizedBox(height: 12.0),

                              labelTypeWidget("Date of Birth"),
                              SizedBox(height: 6.0),

                              CommonTextField(
                                controller: dateOfBirth,
                                hintText: "Select your Date of Birth*",
                                readOnly: true,  // make it readonly, we only pick from calendar
                                trailingWidget: GestureDetector(
                                  onTap: () => _pickDateOfBirth(context),
                                  child: Icon(Icons.calendar_month, color: ColorConstant.greyTextColor, size: 20),
                                ),
                                validator: (val) => validateDateOfBirth(val),
                              ),
                              SizedBox(height: 12.0),

                              labelTypeWidget("Pin code"),
                              SizedBox(height: 6.0),

                              CommonTextField(
                                  controller: pinCodeController,
                                  hintText: "Enter Pin code",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (val){
                                    if(val.trim().length == 6){
                                      context.read<LoanApplicationCubit>().getPinCodeDetailsApiCall(val);
                                    }
                                  },
                                  validator: (val)=> validateIndianPinCode(val)
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
                                hintText: 'Enter PAN Number',
                                keyboardType: TextInputType.text,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  UpperCaseTextFormatter(),
                                ],
                                validator: validatePanCard,
                              ),
                              SizedBox(height: 12.0),

                              labelTypeWidget("Personal Email"),
                              SizedBox(height: 6.0),

                              CommonTextField(
                                  controller: emailController,
                                  hintText: "Enter your Email",
                                  validator: (val) => validateEmail(val)
                              ),
                              SizedBox(height: 24.0),
                            ],
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
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          height: 125,
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
                    onPressed: () async{
                      setState(() {
                        submitted = true;
                      });
                      if(_formKey.currentState!.validate()){
                        var otpModel = await MySharedPreferences.getUserSessionDataNode();
                        VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));
                        context.read<LoanApplicationCubit>().checkEligibilityApiCall(
                            {
                              "custId": verifyOtpModel.data?.custId,
                              "employementType": employmentType,
                              "pincode": pinCodeController.text.trim(),
                              "pancard": panController.text.trim(),
                              "personalEmail": emailController.text.trim(),
                              "stateId": stateId,
                              "cityId": cityId,
                              "stateName": stateController.text.trim(),
                              "cityName": cityController.text.trim(),
                              "mobile": verifyOtpModel.data?.mobile.toString(),
                              "requestSource": ConstText.requestSource,
                              "salaryAmt": int.parse(netMonthlyIncome.text.trim()),
                              "dob": dateOfBirth.text.trim().toString(),
                              "gender":gender,
                              "ip_web":"192.0.0.0",
                              "empName": companyNameController.text.trim()
                            }
                        );
                      }
                    },
                    text: "Check Eligibility"
                ),
                SizedBox(
                  height: 20,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _pickDateOfBirth(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateOfBirth.text = formatted;
    }
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
    required int selectedType,
    required Function(int) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOption(
          label: 'Salaried',
          isSelected: selectedType == 1,
          onTap: () => onChanged(1),
        ),
        const SizedBox(width: 24),
        _buildOption(
          label: 'Self Employed',
          isSelected: selectedType == 2,
          onTap: () => onChanged(2),
        ),
      ],
    );
  }



  Widget modeOfIncomeTypeSelector({
    required int selectedType,
    required Function(int) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOption(
          label: 'Male',
          isSelected: selectedType == 1,
          onTap: () => onChanged(1),
        ),
        const SizedBox(width: 24),
        _buildOption(
          label: 'Female',
          isSelected: selectedType == 2,
          onTap: () => onChanged(2),
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

