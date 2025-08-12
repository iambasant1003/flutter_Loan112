import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Model/GetLoanHistoryModel.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import '../../Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import '../../Model/SendPhpOTPModel.dart';
import '../../Utils/MysharePrefenceClass.dart';

class LoanListPage extends StatefulWidget {
  final GetLoanHistoryModel loanHistoryModel;
  const LoanListPage({super.key,required this.loanHistoryModel});

  @override
  State<LoanListPage> createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  int? _expandedIndex = 0;
  TextEditingController amountController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    return widget.loanHistoryModel.data == null?
        SizedBox.shrink():
        ListView.builder(
      itemCount: widget.loanHistoryModel.data?.length,
      itemBuilder: (context, index) {
        bool isExpanded = _expandedIndex == index;
        var loanData = widget.loanHistoryModel.data?[index];

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_expandedIndex == index) {
                    _expandedIndex = null; // collapse if tapped again
                  } else {
                    _expandedIndex = index; // expand this one
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: index == 0
                      ? LinearGradient(
                    colors: [
                      Color(0xFF2B3C74), // dark blue
                      Color(0xFF5171DA), // light blue
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                      : null,
                  color: index == 0 ? null : (isExpanded ? Colors.blue[50] : Colors.white),
                  border: Border.all(
                    color: isExpanded ? Colors.blue : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: index == 0
                          ? Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          : null,
                      title: Text(
                        index == 0 ? 'Active Loan' : "Loan $index",
                        style: TextStyle(
                          color: index == 0
                              ? Colors.white
                              : (isExpanded ? Colors.blue : Colors.black),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: index == 0
                            ? Colors.white
                            : (isExpanded ? Colors.blue : Colors.black),
                      ),
                    ),
                  ],
                ),
              )
            ),
            if(isExpanded) SizedBox(height: 12.0),
            if (isExpanded) _buildDetailsSection(loanData,index),
          ],
        );
      },
    );
  }

  Widget _buildDetailsSection(var loanData,int index) {
    if(index == 0){
      amountController.text = (loanData.repaymentAmount ?? 0).toString();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          border: Border.all(
            color: ColorConstant.textFieldBorderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: [
              _buildRow("Sanction Loan Amount (Rs.)", "${loanData?.loanRecommended ?? ""}/-"),
              _buildRow("Rate of Interest (%) Per Day", "${loanData?.roi ?? ""}"),
              _buildRow("Date of Sanction", formatDate(loanData?.disbursalDate)),
              _buildRow("Total Repayment Amount (Rs.)", "${loanData?.repaymentAmount ?? ""}/-"),
              _buildRow("Tenure in Days", "${loanData?.tenure ?? ""}"),
              _buildRow("Repayment Date", loanData?.repaymentDate ?? ""),
              _buildRow("Panel Interest (%) Per day", "${loanData?.penalRoi ?? ""}"),
              index ==0?
              SizedBox(height: 12):
              SizedBox.shrink(),
              index ==0?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F2FF), // Light blue background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payable Amount',
                      style: TextStyle(
                        fontWeight: FontConstants.w800,
                        fontSize: FontConstants.f12,
                        color: ColorConstant.blackTextColor,
                        fontFamily: FontConstants.fontFamily
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            controller: amountController,
                            hintText: "Amount",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF2B3C74), // dark blue
                                Color(0xFF5171DA), // light blue
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              String amountText = amountController.text.trim();
                              if (amountText.isEmpty) {
                                openSnackBar(context, "Please enter amount");
                                return;
                              }

                              int enteredAmount = int.tryParse(amountText) ?? 0;
                              int repaymentAmount = int.tryParse(loanData?.repaymentAmount.toString() ?? "0") ?? 0;

                              if (enteredAmount == 0) {
                                openSnackBar(context, "Payable amount should be greater than 0");
                                return;
                              } else if (enteredAmount > repaymentAmount) {
                                openSnackBar(context, "Payable amount should be less than repayment amount");
                                return;
                              }

                              // If all validations pass → navigate
                              context.push(
                                AppRouterName.paymentOptionScreen,
                                extra: {
                                  'loanData': loanData,
                                  'amount': amountText,
                                },
                              ).then((val) {
                                amountController.clear();
                                getLoanHistory();
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'PAY NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ):
              SizedBox.shrink(),
              SizedBox(height: 8)
            ]
          ),
        ),
      ),
    );
  }

  getLoanHistory() async{
    var otpModel = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(otpModel));
    context.read<LoanApplicationCubit>().getLoanHistoryApiCall({
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId
    });
  }

  Widget _buildRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: FontConstants.f12,
                  fontWeight: FontConstants.w700,
                  fontFamily: FontConstants.fontFamily,
                  color: ColorConstant.greyTextColor
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  color: ColorConstant.blueTextColor,
                  fontSize: FontConstants.f12,
                  fontWeight: FontConstants.w800,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
            ),
          ],
        ),
        if(label != "Panel Interest (%) Per day") SizedBox(height: 18)
      ],
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return ''; // or handle error
    }
  }
  
}
