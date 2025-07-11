import 'package:flutter/material.dart';
import '../../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../../Widget/common_button.dart';
import '../../../../../Widget/common_success.dart';

class OnlineBankingMessageScreen extends StatefulWidget{
  const OnlineBankingMessageScreen({super.key});
  @override
  State<StatefulWidget> createState() => _OnlineBankingMessageScreen();

}

class _OnlineBankingMessageScreen extends State<OnlineBankingMessageScreen>{


  @override
  Widget build(BuildContext context) {
    return Loan112VerifyStatusPage(
        isSuccess: true,
        statusType: "Congratulations!",
        statusMessage: "Bank Statement Fetched Successfully.",
        iconTypePath: ImageConstants.oneMoneyIcon,
        loan112button: Loan112Button(
          onPressed: () {},
          text: "CONTINUE",
        )
    );
  }

}