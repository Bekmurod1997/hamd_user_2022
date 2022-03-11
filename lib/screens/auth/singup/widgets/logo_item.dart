import 'package:flutter/material.dart';

class LogoItem extends StatelessWidget {
  final String? imageUrl;
  LogoItem({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: screenSize.height * 0.15,
          right: screenSize.width * 0.14,
          left: screenSize.width * 0.14),
      child: Image.asset(imageUrl!),
    );
  }
}
