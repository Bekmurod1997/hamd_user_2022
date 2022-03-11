import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';

AppBar customAppBar(
  BuildContext context, {
  String? icon1Url,
  final bool? isCart,
  String? title,
  String? icon2Url,
  VoidCallback? onpress1,
  VoidCallback? onpress2,
  double? width1,
  double? height1,
  double? width2,
  double? height2,
  int? productsOnList,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: ColorPalatte.mainPageColor,
    elevation: 0,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 50, left: 26, right: 26, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: IconButton(
                  icon: SvgPicture.asset(
                    icon1Url!,
                    width: width1,
                    height: height1,
                  ),
                  onPressed: onpress1),
            ),
            Text(
              title!.tr,
              style: FontStyles.boldStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: const Color(0xff222E54),
              ),
            ),
            isCart!
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            icon2Url!,
                            width: width2,
                            height: height2,
                          ),
                          onPressed: onpress2,
                        ),
                        productsOnList == 0
                            ? Container()
                            : Positioned(
                                top: 0,
                                right: -5,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: ColorPalatte.strongRedColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      productsOnList.toString(),
                                      // cartListController.allCartList.length
                                      //     .toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        icon: SvgPicture.asset(
                          icon2Url!,
                          width: width2,
                          height: height2,
                        ),
                        onPressed: onpress2),
                  )
          ],
        ),
      ),
    ),
  );
}
