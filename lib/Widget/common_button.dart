import 'package:flutter/material.dart';
import '../Constant/ColorConst/ColorConstant.dart';

class Loan112Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double borderRadius;

  // Optional text style params with defaults
  final String fontFamily;
  final FontWeight fontWeight;
  final double fontSize;
  final double height;
  final double letterSpacing;
  final Color textColor;

  const Loan112Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.borderRadius = 50.0,
    this.fontFamily = 'Manrope',
    this.fontWeight = FontWeight.w700,
    this.fontSize = 18.0,
    this.height = 1.0,
    this.letterSpacing = 0.0,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2B3C74),
              Color(0xFF5171DA),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(
            color: ColorConstant.whiteColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            backgroundColor: Colors.transparent, // 👈 make transparent
            shadowColor: Colors.transparent,     // optional: no shadow
            elevation: 0,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              fontSize: fontSize,
              height: height,
              letterSpacing: letterSpacing,
              color: textColor, // 👈 you can set to white for better contrast
            ),
          ),
        ),
      ),
    );
  }
}
