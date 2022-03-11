import 'package:flutter/material.dart';
import 'package:hamd_user/constants/fonts.dart';

class PageViewItem extends StatelessWidget {
  final String? mytitle;

  PageViewItem({
    this.mytitle,
  });

  Widget build(BuildContext context) {
    return Text(mytitle ?? '',
        style: FontStyles.boldStyle(
            fontSize: 33, fontFamily: 'Ubuntu', color: Colors.white));
  }
}
