import 'package:flutter/material.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Widget/app_bar.dart';

class OnlineBankingOption extends StatefulWidget{
  const OnlineBankingOption({super.key});

  @override
  State<StatefulWidget> createState() => _OnlineBankingOption();
}

class _OnlineBankingOption extends State<OnlineBankingOption>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Loan112AppBar(
        customLeading: InkWell(
          child: Icon(Icons.arrow_back_ios,color: ColorConstant.blackTextColor),
        ),
        centerTitle: true,
        title: Image.asset(ImageConstants.oneMoneyIcon,width: 100,height: 100),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
            child: InkWell(
              onTap: (){},
              child: Text(
                "SKIP",
                style: TextStyle(
                    fontSize: FontConstants.f14,
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontConstants.w600,
                    color: ColorConstant.blueTextColor
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}