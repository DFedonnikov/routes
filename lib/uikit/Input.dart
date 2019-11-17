import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

buildInputField(TextEditingController controller,
    {left = 0,
    top = 0,
    right = 0,
    bottom = 0,
    hint = "",
    obscureText = false}) {
  return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(left),
          top: ScreenUtil.getInstance().setWidth(top),
          right: ScreenUtil.getInstance().setWidth(right),
          bottom: ScreenUtil.getInstance().setWidth(bottom)),
      child: TextFormField(
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: silver),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
          textAlign: TextAlign.center,
          cursorColor: Colors.black,
          controller: controller,
          obscureText: obscureText));
}
