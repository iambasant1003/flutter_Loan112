import 'package:flutter/material.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Widget/app_bar.dart';

class CustomerSupportUiScreen extends StatefulWidget {
  const CustomerSupportUiScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CustomerSupportUiScreen();
}

class _CustomerSupportUiScreen extends State<CustomerSupportUiScreen> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> contactOptions = [
    {
      'icon': Icons.email_outlined,
      'label': 'EMAIL US',
    },
    {
      'icon': Icons.call_outlined,
      'label': 'CALL US',
    },
    {
      'icon': Icons.chat_outlined,
      'label': 'CHAT WITH US',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.appScreenBackgroundColor,
      appBar: Loan112AppBar(
        showBackButton: true,
        centerTitle: true,
        title: Text(
          "Customer Support",
          style: TextStyle(
            fontSize: FontConstants.f18,
            fontWeight: FontConstants.w800,
            fontFamily: FontConstants.fontFamily,
            color: ColorConstant.blackTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: FontConstants.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                "Assistant at your fingertip—connect with our dedicated support team for prompt solution and personalized assistance",
                style: TextStyle(
                  fontSize: FontConstants.f14,
                  fontFamily: FontConstants.fontFamily,
                  fontWeight: FontConstants.w600,
                  color: const Color(0xff4E4F50),
                ),
              ),
              SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Column(
                  children: List.generate(contactOptions.length, (index) {
                    bool isSelected = selectedIndex == index;
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4), // slight spacing
                      padding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE8F2FF)
                            : Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: index == 0
                              ? const Radius.circular(16)
                              : Radius.zero,
                          bottom: index == contactOptions.length - 1
                              ? const Radius.circular(16)
                              : Radius.zero,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            contactOptions[index]['icon'],
                            color: Colors.blue,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              contactOptions[index]['label'],
                              style: TextStyle(
                                fontWeight: FontConstants.w700,
                                fontSize: FontConstants.f14,
                                fontFamily: FontConstants.fontFamily,
                                color: ColorConstant.blackTextColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue.shade50,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
