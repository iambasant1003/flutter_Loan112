import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';

class BankStatementScreen extends StatefulWidget {
  const BankStatementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BankStatementScreen();
}

class _BankStatementScreen extends State<BankStatementScreen> {
  bool isOnlineSelected = true;

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
              SizedBox(height: 24),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: FontConstants.horizontalPadding,
                  ),
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
                        "Choose how would you like to provide your Bank Statement for verification",
                        style: TextStyle(
                          fontSize: FontConstants.f14,
                          fontFamily: FontConstants.fontFamily,
                          fontWeight: FontConstants.w500,
                          color: Color(0xff344054),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildOption(
                            label: "Online",
                            isSelected: isOnlineSelected,
                            onTap: () {
                              setState(() {
                                isOnlineSelected = true;
                              });
                            },
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Aggregator(Recommended)",
                                  style: TextStyle(
                                    fontSize: FontConstants.f16,
                                    fontWeight: FontConstants.w600,
                                    fontFamily: FontConstants.fontFamily,
                                    color: ColorConstant.blackTextColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10, top: 5),
                                  child: Text(
                                    "Securely fetch your bank statement via Account aggregator",
                                    style: TextStyle(
                                      fontSize: FontConstants.f14,
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontConstants.w500,
                                      color: ColorConstant.greyTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          _buildOption(
                            label: "Offline",
                            isSelected: !isOnlineSelected,
                            onTap: () {
                              setState(() {
                                isOnlineSelected = false;
                              });
                            },
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bank Statement PDF",
                                  style: TextStyle(
                                    fontSize: FontConstants.f16,
                                    fontWeight: FontConstants.w600,
                                    fontFamily: FontConstants.fontFamily,
                                    color: ColorConstant.blackTextColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10, top: 5),
                                  child: Text(
                                    "Upload a pdf of your bank statement manually",
                                    style: TextStyle(
                                      fontSize: FontConstants.f14,
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontConstants.w500,
                                      color: ColorConstant.greyTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Center(
                        child: SizedBox(
                          width: 170,
                          child: Loan112Button(
                            onPressed: () {
                              context.push(AppRouterName.onlineBankStatement);
                            },
                            text: "CONTINUE",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required String label,
    required bool isSelected,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? ColorConstant.appThemeColor
                : ColorConstant.greyTextColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: ColorConstant.whiteColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ColorConstant.appThemeColor
                      : ColorConstant.greyTextColor,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.appThemeColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: ColorConstant.blackTextColor,
                fontWeight: FontConstants.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }




}
