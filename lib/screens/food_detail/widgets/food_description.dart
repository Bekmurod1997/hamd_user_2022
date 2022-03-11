// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:hamd_user/constants/fonts.dart';

class ItemDescription extends StatelessWidget {
  final String foodDes;
  // ignore: use_key_in_widget_constructors
  ItemDescription({required this.foodDes});
  @override
  Widget build(BuildContext context) {
    return Text(
      foodDes,
      maxLines: 5,
      style: FontStyles.regularStyle(
        fontSize: 12,
        fontFamily: 'Poppins',
        color: Color(0xff222E54),
      ),
    );
  }
}
