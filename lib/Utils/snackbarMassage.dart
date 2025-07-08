


import 'package:flutter/material.dart';

import '../Constant/ColorConst/ColorConstant.dart';

openSnackBar(BuildContext context, String massage, {Color? backGroundColor}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: backGroundColor ?? ColorConstant.errorRedColor,
          content: Text(massage.toString())
      )
  );
}
