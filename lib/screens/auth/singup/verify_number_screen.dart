import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/screens/auth/singup/widgets/sms_screen_header.dart';
import 'package:hamd_user/screens/auth/singup/widgets/verify_number_form.dart';
import 'package:hamd_user/utils/my_prefs.dart';

import 'widgets/logo_item.dart';

class VerifyNumberScreen extends StatelessWidget {
  const VerifyNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneNumber = MyPref.phoneNumber;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: <Widget>[
                    LogoItem(
                      imageUrl: 'assets/images/logo.png',
                    ),
                    SmsScreenHeader(
                      myText: 'smsWelcome'.tr +
                          ' +998 *** ** ${phoneNumber.substring(14, 17)}',
                    ),
                    const SizedBox(height: 40),
                    const VerifyNumberForm(),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: SingleChildScrollView(
                              child: SizedBox(
                                // height: 440,
                                width: MediaQuery.of(context).size.width * .75,
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Center(
                                            child: Text(
                                              'dilogTitle'.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color:
                                                    ColorPalatte.strongRedColor,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              }),
                                        )
                                      ],
                                    ),
                                    // Text(
                                    //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
                                    // Text(
                                    //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'buAuth'.tr,
                          style: FontStyles.regularStyle(
                              fontSize: 10,
                              fontFamily: 'Ubuntu',
                              color: const Color(0xffBDBDBD)),
                          children: [
                            TextSpan(
                              text: 'condtionAndRules'.tr,
                              style: FontStyles.regularStyle(
                                  fontSize: 10,
                                  fontFamily: 'Ubuntu',
                                  color: ColorPalatte.strongRedColor),
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
