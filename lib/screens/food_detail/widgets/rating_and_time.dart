import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hamd_user/constants/fonts.dart';

class RatingAndItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/star.svg',
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(
                '5.0',
                style: FontStyles.boldStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  color: Color(0xff222E54),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  '(45+)',
                  style: FontStyles.regularStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: const Color(0xff7D8087),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/clock.svg',
                height: 24,
              ),
              SizedBox(width: 10),
              Text(
                '10-15',
                style: FontStyles.mediumStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: Color(0xff494D6D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
