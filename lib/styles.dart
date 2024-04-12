import 'package:flutter/material.dart';

class AppStyles {
  //static Color primaryColor = const Color.fromRGBO(0, 34, 20, 100);
  static const Color primaryColor = Color.fromRGBO(0, 112, 65, 1.0);
  static const Color ghostWhiteColor = Color.fromRGBO(240, 239, 244, 1.0);

  static const TextStyle textGeneralStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor);

  static const InputDecoration inputPrincipalDecoration = InputDecoration(
      focusColor: AppStyles.primaryColor,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: AppStyles.primaryColor, width: 2)),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 10.0, color: Colors.black, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(15))));
}
