import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/fonts.dart';

class SmsScreenHeader extends StatelessWidget {
  final String? myText;
  SmsScreenHeader({this.myText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 30, top: 67),
      child: Text(
        myText!.tr,
        style: FontStyles.regularStyle(
            fontSize: 14, fontFamily: 'Ubuntu', color: Colors.black),
      ),
    );
  }
}
