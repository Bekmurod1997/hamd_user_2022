import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/screens/landing/widgets/language_choice.dart';
import 'package:hamd_user/screens/landing/widgets/pageview.dart';
import 'package:hamd_user/utils/my_prefs.dart';

class LandingScreen extends StatelessWidget {
  String? languageChoice;
  final locales = [
    {'name': 'Uzbek', 'locale': const Locale('uz', 'Uz')},
    {'name': 'Russian', 'locale': const Locale('ru', 'RU')},
  ];
  updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.15,
                  right: screenSize.width * 0.14,
                  left: screenSize.width * 0.14),
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 67),
              child: LanguageChoosing(
                function: () {
                  MyPref.langIndex = 'ru';
                  MyPref.lang = 'ru';
                  MyPref.rusLang = 'ru';
                  MyPref.clearUzbLang();
                  print('my lang choice:');
                  print(MyPref.rusLang);
                  // updateLocale(locales[1]['locale']);
                  Get.to(() => MyPageView());
                },
                // function: () => Get.to(AuthScreen()),
                iconName: 'assets/icons/russia.svg',
                text: 'Русский язык',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LanguageChoosing(
              function: () {
                MyPref.langIndex = 'uz';
                MyPref.lang = 'uz';
                MyPref.uzbLang = 'uz';
                MyPref.clearRusLang();
                print('my lang choice:');
                print(MyPref.uzbLang);
                // updateLocale(locales[0]['locale']);
                Get.to(() => MyPageView());
              },
              // function: () => Get.to(AuthScreen()),

              iconName: 'assets/icons/uzbekistan.svg',
              text: 'O\'zbek tili',
            ),
          ],
        ),
      ),
    );
  }
}
