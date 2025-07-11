import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Screens/loanApplicationPage/loanApplicationOptions/bankStatement/onlinebankStatement/online_banking_step.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';

class OnlineBankingOption extends StatefulWidget{
  const OnlineBankingOption({super.key});

  @override
  State<StatefulWidget> createState() => _OnlineBankingOption();
}

class _OnlineBankingOption extends State<OnlineBankingOption>{


  List<String> accountAggregator = [
    'Enjoy a seamless and secure process with our government-authorized partner, OneMoney.',
    'Grant consent to securely retrieve your salary bank statement.',
    'Your financial data remains confidential and protected.'
  ];

  List<String> stepToGetStarted = [
    "Log in or register with your mobile number",
    "Verify your mobile number.",
    "Select your salaried bank account.",
    "Link your bank account.",
    "Approve access to fetch your latest bank statement."
  ];


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
        SafeArea(
          child: Column(
            children: [
              Loan112AppBar(
                customLeading: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back_ios,
                      color: ColorConstant.blackTextColor),
                ),
                centerTitle: true,
                title: Image.asset(ImageConstants.oneMoneyIcon, width: 100, height: 100),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                            fontSize: FontConstants.f14,
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontConstants.w600,
                            color: ColorConstant.blueTextColor),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: FontConstants.horizontalPadding),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 37),
                          child: Text(
                            "Fetch Your Bank Statement via Account Aggregator",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FontConstants.f18,
                                fontWeight: FontConstants.w700,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.blackTextColor),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ListView.builder(
                            itemCount: accountAggregator.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0.0),
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: CircleAvatar(
                                            radius: 2,
                                            backgroundColor:
                                            ColorConstant.blueTextColor),
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          accountAggregator[index],
                                          style: TextStyle(
                                              fontSize: FontConstants.f12,
                                              fontWeight: FontConstants.w500,
                                              fontFamily:
                                              FontConstants.fontFamily,
                                              color: Color(0xff344054)),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            }),
                        SizedBox(height: 16.0),
                        Center(
                          child: Text(
                            "Simple Steps to Get Started:",
                            style: TextStyle(
                                fontSize: FontConstants.f14,
                                fontWeight: FontConstants.w800,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.blackTextColor),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        GetStartedSteps(stepToGetStarted: stepToGetStarted),
                        SizedBox(height: 80), // leave space for button
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// 🔷 Fixed Bottom Button
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            children: [
              Loan112Button(
                onPressed: () {
                  context.push(AppRouterName.onlineBankStatementMessage);
                },
                text: 'INITIATE',
              )
            ],
          ),
        ),
      ],
    );
  }


}