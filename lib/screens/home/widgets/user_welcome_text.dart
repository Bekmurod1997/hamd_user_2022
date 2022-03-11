import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

class UserWelcomeText extends StatelessWidget {
  const UserWelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          child: Consumer<UserInfoProvider>(
            builder: (context, userInfo, child) {
              return userInfo.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'userWelcomeString1'.tr,
                                    style: FontStyles.regularStyle(
                                      fontSize: 22,
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xff222E54),
                                    ),
                                    children: [
                                      userInfo.userData?.name == null
                                          ? TextSpan(
                                              text: ' ',
                                              style: FontStyles.boldStyle(
                                                fontSize: 22,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff222E54),
                                              ),
                                            )
                                          : TextSpan(
                                              text: ' ' +
                                                  userInfo.userData!.name!,
                                              style: FontStyles.boldStyle(
                                                fontSize: 22,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff222E54),
                                              ),
                                            )
                                    ]),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'userWelcomeString2'.tr,
                                style: FontStyles.regularStyle(
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                    color: const Color(0xff222E54)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                'http://hamd.loko.uz/' +
                                    userInfo.userData!.photo!,
                              )),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
