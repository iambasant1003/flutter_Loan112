import 'package:flutter/material.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';

class LoanListPage extends StatefulWidget {
  const LoanListPage({super.key});

  @override
  State<LoanListPage> createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  int? _expandedIndex = 0; // By default first card expanded

  final loans = List.generate(100, (index) => 'Loan ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loans.length,
      itemBuilder: (context, index) {
        bool isExpanded = _expandedIndex == index;

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_expandedIndex == index) {
                    _expandedIndex = null; // collapse if tapped again
                  } else {
                    _expandedIndex = index; // expand this one
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.blue[50] : Colors.white,
                  border: Border.all(
                    color: isExpanded ? Colors.blue : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        index == 0 ? 'Active Loan' : loans[index],
                        style: TextStyle(
                          color: isExpanded ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: isExpanded ? Colors.blue : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(isExpanded) SizedBox(height: 12.0),
            if (isExpanded) _buildDetailsSection(),
          ],
        );
      },
    );
  }


  Widget _buildDetailsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          border: Border.all(
            color: ColorConstant.textFieldBorderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: [
              _buildRow("Sanction Loan Amount (Rs.)", "25,500/-"),
              _buildRow("Rate of Interest (%) Per Day", "1"),
              _buildRow("Date of Sanction", "19-12-2024"),
              _buildRow("Total Repayment Amount (Rs.)", "45,500/-"),
              _buildRow("Tenure in Days", "10"),
              _buildRow("Repayment Date", "01-12-2024"),
              _buildRow("Panel Interest (%) Per day", "2"),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Amount',
                          border: InputBorder.none, // remove default border
                        ),
                        keyboardType: TextInputType.number,
                      )
                    ),
                  ),
                  SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      // Handle tap here
                    },
                    borderRadius: BorderRadius.circular(70), // to match shape
                    child: Container(
                      width: 95,
                      height: 30,
                      //padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70), // 70px radius
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2B3C74), // dark blue
                            Color(0xFF5171DA), // light blue
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child:  Center(
                        child: Text(
                          "PAY NOW",
                          style: TextStyle(
                            color: ColorConstant.whiteColor,
                            fontWeight: FontConstants.w700,
                            fontSize: FontConstants.f12,
                            fontFamily: FontConstants.fontFamily
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: FontConstants.f12,
                  fontWeight: FontConstants.w700,
                  fontFamily: FontConstants.fontFamily,
                  color: ColorConstant.greyTextColor
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: ColorConstant.blueTextColor,
                fontSize: FontConstants.f12,
                fontWeight: FontConstants.w800,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
          ],
        ),
        if(label != "Panel Interest (%) Per day") SizedBox(height: 18)
      ],
    );
  }
}
