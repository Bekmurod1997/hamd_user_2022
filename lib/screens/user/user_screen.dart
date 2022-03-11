import 'package:flutter/material.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/my_orders_provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/components/header.dart';
import 'package:get/get.dart';
import 'package:hamd_user/screens/user/user_info.dart';
import 'package:hamd_user/screens/user/widgets/edit_profile.dart';
import 'package:hamd_user/screens/user/widgets/my_orders.dart';
import 'package:hamd_user/screens/user/widgets/user_payment.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int selectedIndex = 0;
  int active = 0;
  @override
  void initState() {
    context.read<UserInfoProvider>().fetchUserInfo();
    context.read<MyOrdersProvider>().fetchMyOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              icon1Url: 'assets/icons/Icon-left.svg',
              onpress1: () => Get.back(),
              title: 'profileTitle'.tr,
              icon2Url: 'assets/icons/pencil.svg',
              onpress2: () => Get.to(() => EditProfielScreen()),
              height2: 18,
              height1: 14,
              width1: 14,
              width2: 18,
            ),
            Expanded(
                child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                children: [
                  const UserInfo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: RaisedButton(
                              elevation: 0,
                              color: selectedIndex == 0
                                  ? const Color(0xffE9DCE0)
                                  : Colors.transparent,
                              onPressed: () {
                                if (selectedIndex == 1) {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(
                                'myOrders'.tr,
                                // listOfAllOrdersControllers.orderList.length
                                //     .toString(),
                                style: FontStyles.boldStyle(
                                    fontSize: 15,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 44,
                            child: RaisedButton(
                              elevation: 0,
                              color: selectedIndex == 1
                                  ? const Color(0xffE9DCE0)
                                  : Colors.transparent,
                              onPressed: () async {
                                if (selectedIndex == 0) {
                                  setState(() {
                                    selectedIndex = 1;
                                  });

                                  // context
                                  //     .read<MyOrdersProvider>()
                                  //     .fetchMyOrders();
                                  context
                                      .read<UserInfoProvider>()
                                      .fetchUserInfo();
                                  context
                                      .read<PlasticCardProvider>()
                                      .fetchPlasticCard();
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(
                                'paymentMethod'.tr,
                                style: FontStyles.boldStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  selectedIndex == 0
                      ? Container(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 20),
                          height: 500,
                          child: const MyOrdersScreen(),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const UserPayment(),
                        ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
