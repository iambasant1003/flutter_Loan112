
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../../Cubit/dashboard_cubit/DashboardCubit.dart';
import '../../../../../Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import '../../../../../Model/CheckBankStatementStatusModel.dart';
import '../../../../../Model/SendPhpOTPModel.dart';
import '../../../../../Routes/app_router_name.dart';
import '../../../../../Utils/MysharePrefenceClass.dart';
import '../../../../../Widget/common_button.dart';
import '../../../../../Widget/common_success.dart';

class OnlineBankingMessageScreen extends StatefulWidget{
  final CheckBankStatementStatusModel checkBankStatementStatusModel;
  const OnlineBankingMessageScreen({super.key,required this.checkBankStatementStatusModel});
  @override
  State<StatefulWidget> createState() => _OnlineBankingMessageScreen();

}

class _OnlineBankingMessageScreen extends State<OnlineBankingMessageScreen>{


  @override
  Widget build(BuildContext context) {
    return Loan112VerifyStatusPage(
        onBackPress: (){
          context.pop();
          context.pop();
          context.push(AppRouterName.loanOfferPage,extra: 1).then((val){});
        },
        isSuccess: widget.checkBankStatementStatusModel.success ?? false,
        statusType: (widget.checkBankStatementStatusModel.data?.aaConsentStatus == 1 && (widget.checkBankStatementStatusModel.success ?? false))?
        "Congratulations!":"Failed",
        statusMessage: (widget.checkBankStatementStatusModel.data?.aaConsentStatus == 1 && (widget.checkBankStatementStatusModel.success ?? false))?
        "Bank Statement Fetched Successfully.":"Unable to fetch Bank Statement.",
        iconTypePath: ImageConstants.oneMoneyIcon,
        loan112button: Loan112Button(
          onPressed: () {
            context.pop();
            context.pop();
            context.replace(AppRouterName.loanOfferPage,extra: 1);
          },
          text: "CONTINUE",
        )
    );
  }

  getCustomerDetailsApiCall() async{
    context.read<DashboardCubit>().callDashBoardApi();
    var otpModel = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(otpModel));
    context.read<LoanApplicationCubit>().getCustomerDetailsApiCall({
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId
    });
  }


}

