import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/category_provder.dart';
import 'package:hamd_user/providers/my_orders_provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/cart/cart_screen.dart';
import 'package:hamd_user/screens/components/my_appbar.dart';
import 'package:hamd_user/screens/home/widgets/category_button.dart';
import 'package:hamd_user/screens/home/widgets/food_card.dart';
import 'package:hamd_user/screens/home/widgets/user_welcome_text.dart';
import 'package:hamd_user/screens/user/user_screen.dart';
import 'package:hamd_user/utils/my_prefs.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  double value = 3;
  double driverRating = 4;
  int driver_id = 0;
  int orderId = 0;
  @override
  void didChangeDependencies() async {
    final _read = context.read<CategoryProvider>();
    await _read.fetchAllCategories(context);
    context
        .read<ProductsByCategoryProvider>()
        .fetchProductsByCategory(_read.categoryId);
    print(_read.categoryId);
    super.didChangeDependencies();
  }

  void callingBeforeInit() async {
    print('before init state');
  }

  Future<void> someFunc() async {
    await context.read<MyOrdersProvider>().fetchMyOrders();
    await context.read<PlasticCardProvider>().fetchPlasticCard();
  }

  @override
  void initState() {
    print(MyPref.secondToken);
    // callingBeforeInit();
    context.read<CartListProvider>().fetchProductsOnCard();
    context.read<UserInfoProvider>().fetchUserInfo();

    context.read<MyOrdersProvider>().fetchMyOrders();
    context.read<PlasticCardProvider>().fetchPlasticCard();

    // NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
    _firebaseMessaging.getNotificationSettings();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true, alert: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('navvvvv');
      print('the driver id $driver_id');
      if (message.notification!.title == 'Заказ принят') {
        await someFunc();
        print(jsonEncode(message.data));
        setState(() {
          driver_id = jsonDecode(message.data['driver_id']);
          orderId = jsonDecode(message.data['order_id']);
        });
        print('driverId $driver_id');
        print('orderId $orderId');

        print('payment id');
        print(context.read<MyOrdersProvider>().myOrders.first.paymentType!.id);

        print('the recipt');
        print(context
            .read<MyOrdersProvider>()
            .myOrders
            .first
            .orderReceipt!
            .receiptId);
        Get.snackbar(
          MyPref.lang == 'uz' && message.notification!.title == 'Заказ принят'
              ? 'Buyurtmangiz qabul qilindi'
              : message.notification!.title!,
          MyPref.lang == 'uz' &&
                  message.notification!.body! == 'Ваш заказ приняли'
              ? 'Sizning buyurtmangiz qabul qilindi'
              : message.notification!.body!,
          backgroundColor: Color(0xff007E33),
        );
        print('payment id');
        print(context.read<MyOrdersProvider>().myOrders.first.paymentType!.id);
        // print(context
        //     .read<MyOrdersProvider>()
        //     .myOrders
        //     .first
        //     .orderReceipt!
        //     .receiptId
        //     .toString());
        print('the plastic card id');
        print(context.read<PlasticCardProvider>().myPlastic.first.id);
        if (context.read<MyOrdersProvider>().myOrders.first.paymentType!.id !=
            16) {
          AllServices.payBill(
              id: context
                  .read<MyOrdersProvider>()
                  .myOrders
                  .first
                  .orderReceipt!
                  .id
                  .toString(),
              cardId: context
                  .read<PlasticCardProvider>()
                  .myPlastic
                  .first
                  .id
                  .toString());
        }
      } else if (message.notification!.title == 'Курьер в пути') {
        Get.snackbar(
          MyPref.lang == 'uz' && message.notification!.title == 'Курьер в пути'
              ? 'Kuryer yo\lga chiqidi'
              : message.notification!.title!,
          MyPref.lang == 'uz' && message.notification!.body! == 'Курьер в пути'
              ? 'Kuryer yo\lga chiqdi'
              : message.notification!.body!,
          backgroundColor: Color(0xff007E33),
        );
      } else if (message.notification!.title == 'Заказ завершен') {
        Get.snackbar(
          MyPref.lang == 'uz' && message.notification!.title == 'Заказ завершен'
              ? 'Buyurtma yetkazildi'
              : message.notification!.title!,
          MyPref.lang == 'uz' &&
                  message.notification!.body == 'Ваш заказ завершен'
              ? 'Sizning buyurtmaningiz yetkazildi'
              : message.notification!.body!,
          backgroundColor: Color(0xff007E33),
        );
        Future.delayed(Duration(seconds: 2), () {
          final driverId =
              context.read<MyOrdersProvider>().myOrders.first.courier!.id;
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: Container(
                    // height: 440,
                    width: MediaQuery.of(context).size.width * .75,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/close-alt.svg',
                                width: 22,
                                height: 22,
                              ),
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                        Text(
                          'driverRate'.tr,
                          textAlign: TextAlign.center,
                          style: FontStyles.boldStyle(
                            fontSize: 23,
                            fontFamily: 'Product Sans',
                            color: Color(0xff414141),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: Container(
                            // width: 180,
                            // height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/images/driverS.png'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RatingStars(
                            value: driverRating,
                            // value: value,
                            onValueChanged: (v) {
                              //
                              setState(() {
                                driverRating = v;
                              });
                              AllServices.rateDriver(
                                  driverId.toString(), driverRating.toString());
                              print(driverRating);
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                              size: 35,
                            ),
                            starCount: 5,
                            starSize: 30,

                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: false,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: ColorPalatte.strongRedColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        });
        Future.delayed(Duration(seconds: 15), () {
          List<String> foodIds = [];
          final orderId =
              context.read<MyOrdersProvider>().myOrders.first.orderProducts;

          for (var i = 0;
              i <
                  context
                      .read<MyOrdersProvider>()
                      .myOrders
                      .first
                      .orderProducts!
                      .length;
              i++) {
            foodIds.add(context
                .read<MyOrdersProvider>()
                .myOrders
                .first
                .orderProducts![i]
                .product!
                .id
                .toString());
          }

          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: Container(
                    // height: 440,
                    width: MediaQuery.of(context).size.width * .75,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/close-alt.svg',
                                width: 22,
                                height: 22,
                              ),
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                        Text(
                          'foodRate'.tr,
                          textAlign: TextAlign.center,
                          style: FontStyles.boldStyle(
                            fontSize: 23,
                            fontFamily: 'Product Sans',
                            color: Color(0xff414141),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 40, right: 40),
                        //   child: Container(
                        //     // width: 180,
                        //     // height: 180,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: Image.asset('assets/images/driverS.png'),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RatingStars(
                            value: value,
                            // value: value,
                            onValueChanged: (v) {
                              //
                              setState(() {
                                value = v;
                              });
                              AllServices.rateFood(foodIds, value.toString());
                              Get.back();
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                              size: 35,
                            ),
                            starCount: 5,
                            starSize: 30,

                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: false,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: ColorPalatte.strongRedColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messag) async {
      print('opening app');
      await someFunc();
      if (context.read<MyOrdersProvider>().myOrders.first.paymentType!.id !=
          16) {
        AllServices.payBill(
            id: context
                .read<MyOrdersProvider>()
                .myOrders
                .first
                .orderReceipt!
                .id
                .toString(),
            cardId: context
                .read<PlasticCardProvider>()
                .myPlastic
                .first
                .id
                .toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('-0----');
    // print(context.watch<MyOrdersProvider>().myOrders);
    return Consumer<CartListProvider>(
      builder: (context, cartLit, child) {
        return Scaffold(
          backgroundColor: ColorPalatte.mainPageColor,
          appBar: PreferredSize(
              child: customAppBar(context,
                  isCart: true,
                  icon1Url: 'assets/icons/drawer.svg',
                  height1: 10,
                  width1: 10,
                  onpress1: () => Get.to(() => UserScreen()),
                  title: 'mainMeny',
                  icon2Url: 'assets/icons/shopping-cart.svg',
                  width2: 25,
                  height2: 25,
                  onpress2: () => Get.to(() => const CartScreen()),
                  productsOnList: cartLit.cartList.length),
              preferredSize: Size.fromHeight(
                  kToolbarHeight + MediaQuery.of(context).viewPadding.top)),
          body: cartLit.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UserWelcomeText(),
                                SizedBox(height: 20),
                                CategoryButton(),
                                // CategoryButtons(
                                //   selectedCategory: categoryItemController.tabId(),
                                // ),
                                SizedBox(height: 20),
                                FoodCard(),
                                // FoodCard(
                                //   selectedCategory: categoryItemController.tabId(),
                                // ),
                                SizedBox(height: 20),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
