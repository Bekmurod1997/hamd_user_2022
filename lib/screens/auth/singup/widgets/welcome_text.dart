import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/fonts.dart';

class WelcomeText extends StatelessWidget {
  final String? mainText;
  final String? subText;
  WelcomeText({this.mainText, this.subText});
  //'Добро пожаловать'

  //'Пожалуйста, авторизуйтесь'

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 30, top: 67),
      child: Column(
        children: [
          Text(
            mainText!.tr,
            style: FontStyles.boldStyle(
              fontSize: 27,
              fontFamily: 'Ubuntu',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subText!.tr,
            style: FontStyles.lightStyle(
              fontSize: 19,
              fontFamily: 'Ubuntu',
            ),
          ),
        ],
      ),
    );
  }
}
