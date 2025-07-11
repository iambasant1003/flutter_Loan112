import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_success.dart';

import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Widget/common_button.dart';
import '../../../../Widget/eligibility_status_background.dart';

class EkycMessageScreen extends StatefulWidget{
  const EkycMessageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EkycMessageScreen();
}

class _EkycMessageScreen extends State<EkycMessageScreen>{


  @override
  Widget build(BuildContext context) {
    return Loan112VerifyStatusPage(
        isSuccess: true,
        statusType: "Congratulations!",
        statusMessage: "You have successfully done the E-KYC.",
        iconTypePath: ImageConstants.adarIcon,
        loan112button: Loan112Button(
          onPressed: () {},
          text: "CONTINUE",
        )
    );
  }

}