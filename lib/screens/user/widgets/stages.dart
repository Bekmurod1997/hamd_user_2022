import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_user/constants/fonts.dart';

class Stages extends StatelessWidget {
  final String? bigTitle;
  final String? smallTitle;
  final String? iconUrl;

  Stages({this.bigTitle, this.iconUrl, this.smallTitle});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffF4E5E6)),
          child: Center(
            child: SvgPicture.asset(iconUrl!),
          ),
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  bigTitle ?? '',
                  style: FontStyles.boldStyle(
                    fontSize: 15,
                    fontFamily: 'Ubuntu',
                    color: Color(0xff414141),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                // SvgPicture.asset('assets/icons/small-grey-clock.svg'),
                // SizedBox(
                //   width: 7,
                // ),
                Text(
                  smallTitle ?? '',
                  style: FontStyles.regularStyle(
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                    color: Color(0xff7D7D7D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
