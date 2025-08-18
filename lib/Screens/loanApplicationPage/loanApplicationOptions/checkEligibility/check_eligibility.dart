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
import 'package:loan112_app/Model/GetCustomerDetailsModel.dart';
import 'package:loan112_app/Model/VerifyOTPModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/MysharePrefenceClass.dart';
import 'package:loan112_app/Utils/PanInputFormatter.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/bottom_dashline.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../ParamModel/GetCityAndStateRequest.dart';
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
  String dateOfBirthPassed = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getCustomerDetails();
  }

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

  void getCustomerDetails() async{
    String? customerData = await MySharedPreferences.getCustomerDetails();
    DebugPrint.prt("Data on eligibility check $customerData");
    if(customerData != null){
      CustomerDetails customerDetails = CustomerDetails.fromJson(jsonDecode(customerData));
      setState(() {
        gender = int.parse(customerDetails.gender ?? "1");
        employmentType = int.parse(customerDetails.incomeTypeId ?? "1");
        netMonthlyIncome.text = customerDetails.monthlyIncome ?? "";
        companyNameController.text = customerDetails.empCompanyName ?? "";
        gender = int.parse(customerDetails.gender ?? "1");
        dateOfBirth.text = customerDetails.dob ?? "";
        if (customerDetails.dob != null && customerDetails.dob!.isNotEmpty) {
          DateTime parsedDob = DateFormat('dd-MM-yyyy').parse(customerDetails.dob!);
          dateOfBirthPassed = DateFormat('yyyy-MM-dd').format(parsedDob);
        }
        pinCodeController.text = customerDetails.residencePincode ?? "";
        stateController.text = customerDetails.residenceStateName ?? "";
        cityController.text = customerDetails.residenceCityName ?? "";
        stateId = customerDetails.residenceStateId ?? "";
        cityId = customerDetails.residenceCityId ?? "";
        panController.text = customerDetails.pancard ?? "";
        emailController.text = customerDetails.personalEmail ?? "";
      });
    }
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
            DebugPrint.prt("Create Lead Success");
            MySharedPreferences.setLeadId(state.createLeadModel.data?.leadId ?? "");

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              if(state.createLeadModel.data!.credauLoanOfferPage!){
                context.pop();
                MySharedPreferences.setEnhanceKey("1");
                context.push(AppRouterName.loanOfferPage,extra: 1);
              }else{
                context.pop();
              }
            });
          } else if (state is GetPinCodeDetailsSuccess) {
            EasyLoading.dismiss();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              stateController.text = state.pinCodeDetailsModel.data?.stateName ?? "";
              cityController.text = state.pinCodeDetailsModel.data?.cityName ?? "";
              stateId = state.pinCodeDetailsModel.data?.stateId.toString() ?? "";
              cityId = state.pinCodeDetailsModel.data?.cityId.toString() ?? ""; // You may want to avoid hardcoding this
            });
          } else if (state is CreateLeadError) {
            EasyLoading.dismiss();
              openSnackBar(context, state.createLeadModel.message ?? "UnExpected Error");
          } else if (state is LoanApplicationError) {
            EasyLoading.dismiss();
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
                              SizedBox(height: 18.0),

                              labelTypeWidget("Select Employment Type"),
                              SizedBox(height: 12.0),

                              employmentTypeSelector(
                                selectedType: employmentType,
                                onChanged: (val) {
                                  setState(() {
                                    employmentType = val;
                                  });
                                },
                              ),
                              SizedBox(height: 12.0),

                              labelTypeWidget("Net Monthly Income"),
                              SizedBox(height: 6.0),

                              CommonTextField(
                                controller: netMonthlyIncome,
                                hintText: "Enter your net monthly income*",
                                keyboardType: TextInputType.number,
                                maxLength: 8,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return "Please enter your net monthly income";
                                  }

                                  final trimmedVal = val.trim();
                                  DebugPrint.prt("Value Data  $trimmedVal");

                                  final income = BigInt.tryParse(trimmedVal);
                                  DebugPrint.prt("Income $income");

                                  if (income == null) {
                                    return "Please enter a valid number";
                                  }

                                  if (income <= BigInt.zero) {
                                    return "Income must be greater than zero";
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
                                  }else if(val.trim().length <3){
                                    return "Please enter minimum 3 letter";
                                  }else if(!RegExp(r"^[a-zA-Z0-9][a-zA-Z0-9 .,&'\-]*[a-zA-Z0-9.]$").hasMatch(val)){
                                    return "Please enter valid company name";
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
                                  maxLength: 6,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (val) async{
                                    if(val.trim().length == 6){
                                      var otpModel = await MySharedPreferences.getUserSessionDataNode();
                                      VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));
                                      GetCityAndStateRequest getCityAndStateRequest = GetCityAndStateRequest(
                                          custProfileId: verifyOtpModel.data?.custId ?? "",
                                          leadId: verifyOtpModel.data?.leadId ?? "",
                                          pincode: val.trim()
                                      );
                                      DebugPrint.prt("Get PinCode Data ${getCityAndStateRequest.toJson()}");

                                      context.read<LoanApplicationCubit>().getPinCodeDetailsApiCall(getCityAndStateRequest.toJson());
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
                                  PanInputFormatter()
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
          height: 124,
          color: ColorConstant.whiteColor,
          child: Column(
            children: [
              BottomDashLine(),
              Padding(
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
                            final info = NetworkInfo();
                            final ip = await info.getWifiIP();

                            var dataObj = {
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
                              "dob": dateOfBirthPassed,
                              "gender":gender,
                              "ip_web": ip,
                              "empName": companyNameController.text.trim()
                            };
                            DebugPrint.prt("Data Obj To Api $dataObj");

                            context.read<LoanApplicationCubit>().checkEligibilityApiCall(dataObj);
                          }
                        },
                        text: "Check Eligibility"
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    InkWell(
                      onTap: (){
                        context.push(AppRouterName.customerSupport);
                      },
                      child: Row(
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
                    ),
                    SizedBox(
                      height: 4.0,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pickDateOfBirth(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        DateTime.now().year - 21,
        DateTime.now().month,
        DateTime.now().day,
      ),
      firstDate: DateTime(
        DateTime.now().year - 56,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year - 21,
        DateTime.now().month,
        DateTime.now().day,
      ),
      locale: const Locale('en', 'GB'),   // Forces DD/MM/YYYY entry
    );

    if (pickedDate != null) {
      dateOfBirthPassed = DateFormat('yyyy-MM-dd').format(pickedDate);
      final formattedUi = DateFormat('dd-MM-yyyy').format(pickedDate);
      dateOfBirth.text = formattedUi;
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
              width: 20,
              height: 20,
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

