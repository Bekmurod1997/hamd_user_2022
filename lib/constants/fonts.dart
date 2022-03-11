import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontStyles {
  static boldStyle(
      {double? fontSize, String? fontFamily, Color color = Colors.black}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
        color: color);
  }

  static regularStyle(
      {double? fontSize, String? fontFamily, Color color = Colors.black}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: color);
  }

  static lightStyle(
      {double? fontSize, String? fontFamily, Color color = Colors.black}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        fontFamily: fontFamily,
        color: color);
  }

  static semiBoldStyle(
      {double? fontSize, String? fontFamily, Color color = Colors.black}) {
    return TextStyle(
        letterSpacing: 0.0,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: color);
  }

  static mediumStyle(
      {double? fontSize, String? fontFamily, Color color = Colors.black}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: color);
  }
}
