import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/order_process_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/user/widgets/plastic_card.dart';
import 'package:provider/provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  void initState() {
    context.read<PlasticCardProvider>().fetchPlasticCard();
    context.read<UserInfoProvider>().fetchUserInfo();
    super.initState();
  }

  int paymentIndex = 1;

  @override
  Widget build(BuildContext context) {
    var payments = [
      'assets/icons/uzcard.svg',
      'assets/images/humo.png',
      'assets/icons/money.svg'
    ];
    var paymentTitle = [
      'UzCard',
      'Humo',
      'cash'.tr,
    ];
    return Consumer3<PlasticCardProvider, UserInfoProvider,
        OrderProcessProvider>(
      builder: (context, plastic, userInfo, orderProcess, child) {
        return plastic.isLoading || userInfo.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.only(left: 24, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'paymentTypes'.tr,
                        style: FontStyles.mediumStyle(
                          fontSize: 21,
                          fontFamily: 'Montserrat',
                          color: Color(0xff171101),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            orderProcess.changePaymentType(16);
                            setState(() {
                              paymentIndex = 1;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: SvgPicture.asset(
                                          'assets/icons/money.svg'),
                                    ),
                                    if (paymentIndex == 1)
                                      Positioned(
                                        right: 0,
                                        top: -25,
                                        child: SvgPicture.asset(
                                            'assets/icons/check.svg'),
                                      )
                                  ],
                                ),
                                Text(
                                  'cash'.tr,
                                  style: FontStyles.regularStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff0E0900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            plastic.myPlastic.isNotEmpty &&
                                    plastic.myPlastic.first.cardNumber!
                                        .startsWith('8600')
                                ? orderProcess.changePaymentType(14)
                                : orderProcess.changePaymentType(15);
                            setState(() {
                              paymentIndex = 2;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 40,
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: SvgPicture.asset(
                                          'assets/icons/uzcard.svg'),
                                    ),
                                    if (paymentIndex == 2)
                                      Positioned(
                                        right: 0,
                                        top: -25,
                                        child: SvgPicture.asset(
                                            'assets/icons/check.svg'),
                                      )
                                  ],
                                ),
                                Text(
                                  'uzCard'.tr,
                                  style: FontStyles.regularStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff0E0900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // plastic.myPlastic.first.cardNumber!.startsWith('8600')
                    //     ? Text('UzCard')
                    //     : Text('Humo'),
                    paymentIndex == 2 ? SizedBox(height: 30) : Container(),
                    paymentIndex == 2 && plastic.myPlastic.isNotEmpty
                        ? PlasticCard(
                            plasticId: plastic.myPlastic.first.id.toString(),
                            cardType:
                                plastic.myPlastic.first.paymentType!.name!,
                            cardNumber: plastic.myPlastic.first.cardNumber,
                            dateExpire: plastic.myPlastic.first.cardExpire,
                            phoneNumber:
                                plastic.myPlastic.first.cardPhoneNumber,
                            name: userInfo.userData?.name ?? 'Enter Name',
                          )
                        : paymentIndex == 2 && plastic.myPlastic.isEmpty
                            ? Text(
                                'Пожалуйста, добавьте карту через раздел аккаунта')
                            : Container(),
                  ],
                ),
              );
      },
    );
  }
}
