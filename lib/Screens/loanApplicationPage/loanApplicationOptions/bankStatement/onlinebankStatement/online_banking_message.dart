
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../../Model/CheckBankStatementStatusModel.dart';
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
        },
        isSuccess: widget.checkBankStatementStatusModel.success ?? false,
        statusType: (widget.checkBankStatementStatusModel.data == 1 && (widget.checkBankStatementStatusModel.success ?? false))?
        "Congratulations!":"Failed",
        statusMessage: (widget.checkBankStatementStatusModel.data == 1 && (widget.checkBankStatementStatusModel.success ?? false))?
        "Bank Statement Fetched Successfully.":"Unable to fetch Bank Statement.",
        iconTypePath: ImageConstants.oneMoneyIcon,
        loan112button: Loan112Button(
          onPressed: () {
            context.pop();
            context.pop();
          },
          text: "CONTINUE",
        )
    );
  }


}

