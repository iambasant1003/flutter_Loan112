
import 'package:flutter/material.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';

class StepItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isCurrent;

  const StepItem({
    super.key,
    required this.title,
    this.isCompleted = false,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = isCompleted || isCurrent ? Colors.blue : Colors.grey.shade300;

    // Gradient when completed
    Gradient? gradient = isCompleted
        ? const LinearGradient(
      colors: [
        Color(0xFF2B3C74), // dark blue
        Color(0xFF5171DA), // light blue
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    )
        : null;

    Color bgColor = isCurrent
        ? Colors.white
        : Colors.grey.shade100;

    Widget leadingIcon = isCompleted
        ? const Icon(Icons.check_circle, color: Colors.white)
        : Icon(Icons.arrow_forward, color: Color(0xFF2B3C74));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: gradient == null ? bgColor : null, // use solid if no gradient
        gradient: gradient,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: leadingIcon,
        title: Text(
          title,
          style: (isCompleted || isCurrent)?
          TextStyle(
            color: isCompleted ? ColorConstant.whiteColor : ColorConstant.blackTextColor,
            fontWeight: FontConstants.w700,
            fontFamily: FontConstants.fontFamily,
            fontSize: FontConstants.f16
          ):
          TextStyle(
              color: ColorConstant.dashboardTextColor,
              fontWeight: FontConstants.w500,
              fontFamily: FontConstants.fontFamily,
              fontSize: FontConstants.f16
          ),
        ),
      ),
    );
  }
}
