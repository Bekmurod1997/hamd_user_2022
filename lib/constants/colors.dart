import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorPalatte {
  static const mainPageColor = Color(0xffF1F4F7);
  static const nextButtonColor = Color(0xffFF2020);
  static const plaseAuthColor = Color(0xffF1F4F7);
  static const orderButtonColor = Color(0xff9F111B);
  static const strongRedColor = Color(0xff9F111B);
  static const blackColor = Colors.black;

  static setStatusBarColor({Color color = const Color(0xffF1F4F7)}) {
    return const SystemUiOverlayStyle(
      statusBarColor: Color(0xffF1F4F7),
      statusBarBrightness: Brightness.dark,
    );
  }
}
