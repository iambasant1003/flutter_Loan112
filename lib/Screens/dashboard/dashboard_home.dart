
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constant/ColorConst/ColorConstant.dart';
import '../../Constant/FontConstant/FontConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../../Widget/circular_progress.dart';
import '../../Widget/common_button.dart';

class DashBoardHome extends StatefulWidget{
  const DashBoardHome({super.key});

  @override
  State<StatefulWidget> createState() => _DashBoardHome();
}

class _DashBoardHome extends State<DashBoardHome>{

  final PageController _controller = PageController();

  List<String> imageData = ["Ram","Shyam"];


  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.permissionScreenBackground,
              fit: BoxFit.cover, // Optional: to scale and crop nicely
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 37,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      personalLoanApplyWidget(context),
                      Positioned(
                        top: -2,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstant.appThemeColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(18.0),
                                bottomRight: Radius.circular(18.0),
                              ),
                            ),
                            width: 244,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Easy personal Loans",
                                style: TextStyle(
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: FontConstants.f18,
                                  fontWeight: FontConstants.w800,
                                  color: ColorConstant.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -25,
                          left: 100,
                          right: 100,
                          child: Loan112Button(
                              onPressed: (){
                                context.push(AppRouterName.loanApplicationPage);
                              },
                              text: "Let's Start"
                          )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: FontConstants.horizontalPadding),
                    child: Text(
                      "We Provide",
                      style: TextStyle(
                          fontSize: FontConstants.f18,
                          fontWeight: FontConstants.w800,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.blackTextColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: imageData.length,
                      itemBuilder: (context, index) {
                        final item = imageData[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstants.emergencyLoanPoster),
                                  fit: BoxFit.fill
                              ),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                )
                              ],
                            ),
                           // child: Image.asset(ImageConstants.emergencyLoanPoster)
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: imageData.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget personalLoanApplyWidget(BuildContext context){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstants.permissionScreenLeftPyramid,width: 26,height: 13),
            SizedBox(
              width: 214,
            ),
            Image.asset(ImageConstants.permissionScreenRightPyramid,width: 26,height: 13.0),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            //vertical: 32,
          ),
          padding: const EdgeInsets.all(FontConstants.horizontalPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
              // other content goes here
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Discover the possibilities with an instant personal loan up to Rs 1.2 Lakh. Curious about your eligibility? There's only one way to find out",
                      style: TextStyle(
                          fontWeight: FontConstants.w600,
                          fontSize: FontConstants.f14,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.greyTextColor
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  CircularProgressWithText(
                    progress: 0.5,
                    isDrawer: false,
                  )
                ],
              ),
              SizedBox(height: 24.0),
            ],
          ),
        )
      ],
    );
  }


}






