import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';

buildInputField(TextEditingController controller,
    {double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
    hint = "",
    obscureText = false}) {
  return Padding(
      padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom),
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
