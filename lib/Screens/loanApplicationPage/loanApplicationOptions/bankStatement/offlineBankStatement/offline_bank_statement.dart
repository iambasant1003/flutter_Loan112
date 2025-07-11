


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:widgets_easier/widgets_easier.dart';
import '../../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../../Widget/app_bar.dart';



class FetchOfflineBankStatement extends StatefulWidget{
  const FetchOfflineBankStatement({super.key});

  @override
  State<StatefulWidget> createState() => _FetchOfflineBankStatement();
}

class _FetchOfflineBankStatement extends State<FetchOfflineBankStatement>{

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImageConstants.logInScreenBackGround,
            fit: BoxFit.cover,
          ),
        ),

        /// Form + Button
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Loan112AppBar(
                customLeading: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorConstant.blackTextColor,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bank Statement",
                        style: TextStyle(
                          fontSize: FontConstants.f20,
                          fontWeight: FontConstants.w800,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.blackTextColor,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Please provide your latest bank statement.",
                        style: TextStyle(
                          fontSize: FontConstants.f14,
                          fontFamily: FontConstants.fontFamily,
                          fontWeight: FontConstants.w500,
                          color: Color(0xff344054),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          shape: DashedBorder(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstant.appThemeColor
                          ),
                          image: DecorationImage(
                            image: AssetImage(ImageConstants.selectBankStatementCardBackground),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(19.0),
                          child: Text(
                            'This is some longer text that will make the container grow vertically and horizontally as needed.\nAdd more lines and it keeps growing! uddurufhrfuhrfurhufrf fjurjfr4ufjur4fjuf jfjrjffjrfurfufufr4ufj43 juruufrufurfrfurrf',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


}



