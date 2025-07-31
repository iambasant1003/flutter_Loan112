import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';

class Loan112AppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool showBackButton;
  final Widget? customLeading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double? leadingSpacing;
  final Color? backgroundColor; // <--- NEW

  const Loan112AppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.customLeading,
    this.actions,
    this.centerTitle = false,
    this.leadingSpacing,
    this.backgroundColor, // <--- NEW
  });

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (customLeading != null) {
      leadingWidget = customLeading;
    } else if (showBackButton) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: ColorConstant.blackTextColor,
        onPressed: () {
          context.pop();
        },
      );
    }

    return AppBar(
      leadingWidth: leadingSpacing,
      leading: leadingWidget ?? const SizedBox.shrink(),
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent, // <--- HERE
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
