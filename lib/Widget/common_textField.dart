import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constant/ColorConst/ColorConstant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  /// Fully customizable trailing widget
  final Widget? trailingWidget;

  /// Optional click callback if you want the trailingWidget to be wrapped in a clickable
  final VoidCallback? trailingClick;

  /// Optional readOnly flag for fields like DOB
  final bool readOnly;

  /// Optional obscureText flag for password fields
  final bool obscureText;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.hintStyle,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.trailingWidget,
    this.trailingClick,
    this.readOnly = false,
    this.obscureText = false, // 👈 added with default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8.0));
    const normalBorderColor = ColorConstant.textFieldBorderColor;
    const errorBorderColor = ColorConstant.errorRedColor;

    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      obscureText: obscureText, // 👈 use the new property
      style: const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.71,
        letterSpacing: 0,
      ),
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.71,
              letterSpacing: 0,
              color: Color(0xFF98A2B3),
            ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        enabledBorder: border(normalBorderColor),
        focusedBorder: border(normalBorderColor),
        errorBorder: border(errorBorderColor),
        focusedErrorBorder: border(errorBorderColor),
        suffixIcon: trailingWidget != null
            ? GestureDetector(
          onTap: trailingClick ?? () {},
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: trailingWidget,
          ),
        )
            : null,
      ),
    );
  }
}
