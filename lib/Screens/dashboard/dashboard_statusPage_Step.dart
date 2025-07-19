import 'package:flutter/material.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Constant/ImageConstant/ImageConstants.dart';

class DashboardStatuspageStep extends StatelessWidget {

   DashboardStatuspageStep({super.key,required this.currentStep});

  final int currentStep; // index of current in-progress step (1-based)

  final List<String> steps = [
    "Application Submitted",
    "Application in Review",
    "Sanction",
    "E-Sign Letter",
    "Disbursement",
  ];

  final List<String> icons = [
    ImageConstants.applicationSubmitted,
    ImageConstants.applicationReview,
    ImageConstants.applicationSanction,
    ImageConstants.applicationESign,
    ImageConstants.applicationDisbursement
  ];


   @override
   Widget build(BuildContext context) {
     return Column(
       children: List.generate(steps.length, (index) {
         bool isCompleted = index + 1 < currentStep;
         bool isCurrent = index + 1 == currentStep;

         double widthFactor = isCompleted
             ? 1.0
             : isCurrent
             ? 0.8
             : 0.6;

         Color bgColor = isCompleted || isCurrent
             ? Colors.blue.shade50
             : Colors.grey.shade100;

         Color textColor = isCompleted || isCurrent
             ? ColorConstant.dashboardTextColor
             : ColorConstant.greyTextColor;

         return Container(
           margin: const EdgeInsets.symmetric(vertical: 6),
           child: Stack(
             children: [
               // Full width transparent base
               Container(
                 decoration: BoxDecoration(
                   color: Colors.grey.shade100,
                   borderRadius: BorderRadius.circular(12),
                 ),
               ),
               // Colored portion with variable width
               FractionallySizedBox(
                 widthFactor: widthFactor,
                 child: Container(
                   decoration: BoxDecoration(
                     color: bgColor,
                     borderRadius: BorderRadius.circular(12),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black12,
                         blurRadius: 3,
                         offset: const Offset(0, 2),
                       ),
                     ],
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                   child: Row(
                     children: [
                       Text(
                         "${index + 1}".padLeft(2, '0'),
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: textColor,
                         ),
                       ),
                       const SizedBox(width: 12),
                       Expanded(
                         child: Text(
                           steps[index],
                           style: TextStyle(
                             fontWeight: FontConstants.w700,
                             fontSize: FontConstants.f16,
                             fontFamily: FontConstants.fontFamily,
                             color: textColor,
                           ),
                         ),
                       ),
                       CircleAvatar(
                         backgroundColor: ColorConstant.drawerHeaderColor,
                         radius: 18,
                         child: Image.asset(
                           icons[index],
                           color: textColor,
                           height: 20,
                           width: 20
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             ],
           ),
         );
       }),
     );
   }


}
