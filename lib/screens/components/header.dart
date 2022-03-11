import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/fonts.dart';

class Header extends StatelessWidget {
  final bool? hasAction;
  final String? icon1Url;
  final String? title;
  final String? icon2Url;
  final VoidCallback? onpress1;
  final VoidCallback? onpress2;
  final double? width1;
  final double? height1;
  final double? width2;
  final double? height2;
  final bool isSecondIconSee;

  Header({
    this.icon1Url,
    this.onpress1,
    this.title,
    this.height1,
    this.width1,
    this.hasAction = true,
    this.icon2Url,
    this.onpress2,
    this.height2,
    this.width2,
    this.isSecondIconSee = true,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 26, right: 26, bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: IconButton(
                  icon: mySvg(icon1Url!, width: width1!, height: height1!),
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
            isSecondIconSee || hasAction!
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        icon:
                            mySvg(icon2Url!, width: width2!, height: height2!),
                        onPressed: onpress2),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  SvgPicture mySvg(String iconUrl, {double width = 14, double height = 14}) {
    return SvgPicture.asset(
      iconUrl,
      height: height,
      width: width,
    );
  }
}
