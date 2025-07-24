import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/AddMoreReferenceCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import 'package:loan112_app/Cubit/loan_application_cubit/LoanApplicationState.dart';
import 'package:loan112_app/ParamModel/AddReferenceParamModel.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/common_button.dart';
import 'package:loan112_app/Widget/common_screen_background.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Model/VerifyOTPModel.dart';
import '../../../../Utils/MysharePrefenceClass.dart';
import '../../../../Utils/validation.dart';
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
  TextEditingController referAnceNameController2 = TextEditingController();
  TextEditingController referAnceNumberController2 = TextEditingController();
  TextEditingController referAnceNameControllerTwo2 = TextEditingController();
  TextEditingController referAnceNumberControllerTwo2 = TextEditingController();

  final List<String> relationsDataList = [
    "Parents",
    "Relative",
    "Friends",
    "Colleague",
    "Brother",
    "Other"
  ];

  String? selectedValue;
  String? selectedValue2;

  @override
  void initState() {
    super.initState();
    context.read<AddMoreReferenceCubit>().clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoanApplicationCubit,LoanApplicationState>(
        listener: (context,state){
          if(state is LoanApplicationLoading){
            EasyLoading.show(status: "Please wait...");
          }else if(state is AddReferenceSuccess){
            EasyLoading.dismiss();
            openSnackBar(context, state.addReferenceModel.data?.finalResult ?? "Success",backGroundColor: ColorConstant.appThemeColor);
            context.pop();
          }else if(state is AddReferenceFailed){
            EasyLoading.dismiss();
            openSnackBar(context, state.addReferenceModel.message ?? "Unknown Error");
          }
        },
        child: GradientBackground(
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
                              height: 16.0,
                            ),
                            addReferenceFormData(context),
                            BlocBuilder<AddMoreReferenceCubit,bool>(
                              builder: (context, bool data){
                                return data?
                                addReferenceFormData2(context):
                                Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 22,
                                      ),
                                      addMoreReferenceUI(context)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            Image.asset(ImageConstants.bottomDashLine),
            Padding(
              padding: EdgeInsets.only(bottom: 22,left: 16,right: 16,top: 10),
              child: Loan112Button(
                 onPressed: (){
                   addReferenceApiCallFunction(context);
                 },
                  text: "CONTINUE"
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addReferenceFormData(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        selectRelationType(context,1),
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
            hintText: "Enter mobile number",
            validator: (value) {
              return validateMobileNumber(value);
            },
        ),
      ],
    );
  }

  Widget addReferenceFormData2(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12.0,
        ),
        Text(
          "Reference Name-2",
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
            controller: referAnceNameController2,
            hintText: "Enter your Reference Name"
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          "Relation-2",
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
        selectRelationType(context,2),
        SizedBox(
          height: 12.0,
        ),
        Text(
          "Mobile No.-2",
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
            controller: referAnceNumberController2,
            validator: (value) {
              return validateMobileNumber(value);
            },
            hintText: "Enter mobile number"
        ),
      ],
    );
  }

  Widget selectRelationType(BuildContext context,int type){
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
        items: relationsDataList
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
        value: type == 1?selectedValue:selectedValue2,
        onChanged: (value) {
          if(type ==1){
            setState(() {
              selectedValue = value;
            });
          }else{
            setState(() {
              selectedValue2 = value;
            });
          }
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
    return InkWell(
      onTap: (){
        context.read<AddMoreReferenceCubit>().updateReference(true);
      },
      child: Container(
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
      ),
    );
  }

  void addReferenceApiCallFunction(BuildContext context) async{
    AddReferenceParamModel referenceParamModel = AddReferenceParamModel();
    List<Reference> referenceData = [];
      Reference reference = Reference();
      reference.referenceMobile = referAnceNumberController.text.trim();
      reference.referenceName = referAnceNameController.text.trim();
      reference.referenceRelation = relationsDataList.indexOf(selectedValue?? "")+1;
      referenceData.add(reference);
      if(referAnceNameController2.text.trim() != "" && referAnceNumberController2.text.trim() != "" && selectedValue2 != null){
        Reference referenceSecond = Reference();
        referenceSecond.referenceMobile = referAnceNumberController2.text.trim();
        referenceSecond.referenceName = referAnceNameController2.text.trim();
        referenceSecond.referenceRelation = relationsDataList.indexOf(selectedValue2?? "")+1;
        referenceData.add(referenceSecond);
      }

    var otpModel = await MySharedPreferences.getUserSessionDataNode();
    VerifyOTPModel verifyOtpModel = VerifyOTPModel.fromJson(jsonDecode(otpModel));

    var customerId = verifyOtpModel.data?.custId;
    var leadId = verifyOtpModel.data?.leadId;
    if(leadId == "" || leadId == null){
      leadId = await MySharedPreferences.getLeadId();
    }

      referenceParamModel.custId = customerId;
      referenceParamModel.leadId = leadId;
      referenceParamModel.referenceList = referenceData;

      context.read<LoanApplicationCubit>().addReferenceApiCall(referenceParamModel.toJson());

  }

}

