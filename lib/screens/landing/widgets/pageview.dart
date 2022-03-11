import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/screens/auth/singup/auth_screen.dart';
import 'package:hamd_user/screens/landing/widgets/pageview_item.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var loc = Get.locale;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/slider.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/hamd-logo.svg',
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 4,
                  child: PageView(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    children: [
                      PageViewItem(
                          mytitle:
                              // 'ЗАКАЖИ СВОЙ ЛЮБИМЫЙ  ЛАВАШ В HAMD ЗА ПАРУ КЛИКОВ!',
                              'landingWelcomeString1'.tr),
                      PageViewItem(
                        mytitle: 'landingWelcomeString2'.tr,
                        // mytitle: 'ОТСЛЕЖИВАЙТЕ ВАШИ ЗАКАЗЫ ОНЛАЙН!',
                      ),
                      PageViewItem(
                        mytitle: 'landingWelcomeString3'.tr,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      3,
                      (index) => buildDots(index: index),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 54,
                        width: screenSize.width * 0.8,
                        child: RaisedButton(
                          elevation: 0,
                          color: ColorPalatte.nextButtonColor,
                          onPressed: () => currentPage == 2
                              ? Get.to(() => const AuthScreen())
                              : _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            currentPage == 2
                                ? 'authButton'.tr
                                : 'nextButton'.tr,
                            style: FontStyles.boldStyle(
                                fontSize: 16,
                                fontFamily: 'Ubuntu',
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      currentPage == 2
                          ? Container()
                          : TextButton(
                              onPressed: () => Get.to(() => const AuthScreen()),
                              // onPressed: () => _pageController.animateToPage(
                              //       2,
                              //       duration: Duration(milliseconds: 500),
                              //       curve: Curves.ease,
                              //     ),
                              child: Text(
                                'skipButton'.tr,
                                style: FontStyles.boldStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white),
                              ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDots({int? index}) {
    int curPage = currentPage;
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: curPage == index ? 20 : 7.0,
      height: 7,
      decoration: BoxDecoration(
        borderRadius: curPage == index
            ? BorderRadius.circular(6.0)
            : BorderRadius.circular(10.0),
        color: curPage == index ? Colors.red : Colors.white,
      ),
    );
  }
}
