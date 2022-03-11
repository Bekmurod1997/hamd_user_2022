import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/providers/order_process_provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/cart/widgets/payment_method.dart';
import 'package:hamd_user/screens/payment/widgets/payment_card.dart';
import 'package:hamd_user/screens/payment/widgets/payment_detail.dart';
import 'package:hamd_user/screens/user/widgets/plastic_card.dart';
import 'package:provider/provider.dart';

import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/delivery_price_provider.dart';
import 'package:hamd_user/screens/components/header.dart';
import 'package:hamd_user/models/cart_list_model.dart';

class PaymentScreen extends StatefulWidget {
  final List<Data> orders;
  final String address;

  final String addressLatLng;

  final int selectedIndex;

  const PaymentScreen(
      {Key? key,
      required this.address,
      required this.addressLatLng,
      required this.selectedIndex,
      required this.orders})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool orderLoading = false;
  bool isOrdered = false;
  int sum = 0;
  int? finalPrice;
  int paymentIndex = 1;
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
  @override
  void initState() {
    context.read<PlasticCardProvider>().fetchPlasticCard();
    context.read<UserInfoProvider>().fetchUserInfo();
    for (var i = 0; i < widget.orders.length; i++) {
      setState(() {
        sum += widget.orders[i].totalPrice!;
      });
    }
    if (widget.selectedIndex == 1) {
      setState(() {
        finalPrice = sum + context.read<DeliveryPriceProvider>().price;
      });
    }
    super.initState();
  }

  int changer(int price) {
    return price + context.read<DeliveryPriceProvider>().price;
  }

  @override
  Widget build(BuildContext context) {
    // var recievedIndex = Get.arguments;
    // var recieve = ModalRoute.of(context)!.settings.arguments;
    // final screenSize = MediaQuery.of(context).size;
    // final myLocation = recievedIndex[2];
    // print('myaddress ${recievedIndex[1]}');
    // print('recieved index is: $recievedIndex');

    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              icon1Url: 'assets/icons/Icon-left.svg',
              onpress1: () => Get.back(),
              title: 'orderStatus'.tr,
              icon2Url: 'assets/icons/close.svg',
              onpress2: () => Get.back(),
              height2: 18,
              height1: 14,
              width1: 14,
              width2: 18,
            ),
            Consumer3<OrderProcessProvider, PlasticCardProvider,
                UserInfoProvider>(
              builder: (context, orderProcess, plasticCard, userInfo, child) {
                return plasticCard.isLoading || userInfo.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => Column(
                            children: [
                              PaymentCard(
                                sendIndex: widget.selectedIndex,
                                deliveryPrice:
                                    context.read<DeliveryPriceProvider>().price,
                                total: finalPrice,
                                totalFoodPrice: sum,
                              ),
                              SizedBox(height: 32),
                              PaymentDetailScreen(),
                              SizedBox(height: 32),
                              // PaymentMethod(),
                              Padding(
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
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  overflow: Overflow.visible,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      margin: EdgeInsets.only(
                                                          bottom: 5.0),
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
                                                  style:
                                                      FontStyles.regularStyle(
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
                                            plasticCard.myPlastic.isNotEmpty &&
                                                    plasticCard.myPlastic.first
                                                        .cardNumber!
                                                        .startsWith('8600')
                                                ? orderProcess
                                                    .changePaymentType(14)
                                                : orderProcess
                                                    .changePaymentType(15);
                                            setState(() {
                                              paymentIndex = 2;
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  overflow: Overflow.visible,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      margin: EdgeInsets.only(
                                                          bottom: 5.0),
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
                                                  style:
                                                      FontStyles.regularStyle(
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
                                    paymentIndex == 2
                                        ? SizedBox(height: 30)
                                        : Container(),
                                    paymentIndex == 2 &&
                                            plasticCard.myPlastic.isNotEmpty
                                        ? PlasticCard(
                                            plasticId: plasticCard
                                                .myPlastic.first.id
                                                .toString(),
                                            cardType: plasticCard.myPlastic
                                                .first.paymentType!.name!,
                                            cardNumber: plasticCard
                                                .myPlastic.first.cardNumber,
                                            dateExpire: plasticCard
                                                .myPlastic.first.cardExpire,
                                            phoneNumber: plasticCard.myPlastic
                                                .first.cardPhoneNumber,
                                            name: userInfo.userData?.name ??
                                                'Enter Name',
                                          )
                                        : paymentIndex == 2 &&
                                                plasticCard.myPlastic.isEmpty
                                            ? Text(
                                                'Пожалуйста, добавьте карту через раздел аккаунта')
                                            : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32),

                              // PaymentCard(
                              //     sendIndex: recievedIndex[0],
                              //   ),

                              paymentIndex == 2 && plasticCard.myPlastic.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      height: 63,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          if (isOrdered == false) {
                                            print('presssinggg');
                                            setState(() {
                                              orderLoading = true;
                                              isOrdered = true;
                                            });
                                            await AllServices.makeOrder(
                                                address: widget.address,
                                                location: widget.addressLatLng,
                                                deliveryType:
                                                    orderProcess.deliveryType,
                                                paymentType:
                                                    orderProcess.paymentType);
                                            setState(() {
                                              orderLoading = false;
                                            });
                                            context
                                                .read<DeliveryPriceProvider>()
                                                .resetPrice(0);
                                          } else {
                                            print('already pressed');
                                          }
                                        },
                                        elevation: 0,
                                        color: const Color(0xff9F111B),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: orderLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                'orderButton'.tr,
                                                style: FontStyles.mediumStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
