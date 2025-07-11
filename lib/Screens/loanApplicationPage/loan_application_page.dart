import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/circular_progress.dart';
import '../../Constant/ColorConst/ColorConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../../Widget/common_step.dart';

class LoanApplicationPage extends StatefulWidget{
  const LoanApplicationPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoanApplicationPage();
}

class _LoanApplicationPage extends State<LoanApplicationPage>{

  final int currentStep = 7;

  final List<String> steps = [
    "Check Eligibility",
    "eKYC",
    "Selfie Verification",
    "Fetch Bank Statement",
    "Get Loan Offer",
    "Employment Details",
    "Utility bills",
    "Add References",
    "Banking Details"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Loan112AppBar(
        customLeading: InkWell(
          onTap: (){
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios,color: ColorConstant.blackTextColor),
        ),
        title: Text(
          "Your Loan Application",
          style: TextStyle(
            fontSize: FontConstants.f18,
            fontWeight: FontConstants.w700,
            fontFamily: FontConstants.fontFamily,
            color: ColorConstant.blackTextColor
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffE7F3FF),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                ImageConstants.permissionScreenBackground,
                fit: BoxFit.cover, // Optional: to scale and crop nicely
              ),
            ),
            Positioned(
              left: 15,
              right: 15,
              top: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 90,
                          child: CircularProgressWithText(
                            progress: 0.1,
                            isDrawer: false,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Text(
                            "Begin your journey to financial empowerment-provide the necessary details to initiate your loan application.",
                            style: TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontConstants.w500,
                                fontSize: FontConstants.f14,
                                color: ColorConstant.dashboardTextColor
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // 👇 Wrap with Expanded
                    Expanded(
                      child: ListView.builder(
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          bool isCompleted = index < currentStep;
                          bool isCurrent = index == currentStep;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  if(steps[index].toLowerCase().contains('eligibility')){
                                    context.push(AppRouterName.checkEligibilityPage);
                                  }else if(steps[index].toLowerCase().contains('statement')){
                                    context.push(AppRouterName.bankStatement);
                                  }else if(steps[index].toLowerCase().contains('ekyc')){
                                    context.push(AppRouterName.aaDarKYCScreen);
                                  }
                                },
                                child: StepItem(
                                  title: steps[index],
                                  isCompleted: isCompleted,
                                  isCurrent: isCurrent,
                                ),
                              ),
                              // add line below except for last item
                              if (index != steps.length - 1)
                                const SizedBox(height: 4),
                              if (index != steps.length - 1)
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    height: 20,
                                    width: 2,
                                    color: index < currentStep - 1
                                        ? Colors.blue // completed line color
                                        : Colors.grey.shade300, // pending line color
                                  ),
                                ),
                              if(index == steps.length-1)
                                SizedBox(
                                  height: 20,
                                )
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }


}