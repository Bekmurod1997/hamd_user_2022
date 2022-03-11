import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fontSize.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/adding_card_provider.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/delivery_price_provider.dart';
import 'package:hamd_user/providers/order_process_provider.dart';
import 'package:hamd_user/screens/cart/widgets/map_screen.dart';
import 'package:hamd_user/screens/components/header.dart';
import 'package:get/get.dart';
import 'package:hamd_user/screens/payment/payment_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int sum = 0;
  int? finalPrice;
  @override
  void initState() {
    // context.read<CartListProvider>().fetchProductsOnCard();
    // context.read<CartListProvider>().fetchTotalSumOfProducts();
    // fetchDataa();

    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int changer(int price) {
    return price + context.read<DeliveryPriceProvider>().price;
  }

  final TextEditingController addressController = TextEditingController();
  int selectedRadio = 1;
  selectedRadioValue(int? val) {
    selectedRadio = val!;
  }

  bool incrementLoading = false;
  bool decrementLoading = false;
  double lat = 0.0;
  double lng = 0.0;
  String? addressLatLng;
  LatLng? recievedLatLng;

  void incrment(int index) async {
    if (incrementLoading) return;
    incrementLoading = true;

    final _read = context.read<CartListProvider>();
    final _addProcutRead = context.read<AddingCardProvider>();
    int productCount = _read.cartList[index].amount!;
    final productPrice = _read.cartList[index].productPrice!;
    productCount++;
    sum += productPrice;
    await _addProcutRead.addingToCard(
      productId: _read.cartList[index].productId!,
      productCount: productCount,
      context: context,
    );

    // Navigator.pop(context);
    incrementLoading = false;
    setState(() {});
  }

  void decrement(int index) async {
    if (incrementLoading) return;
    decrementLoading = true;

    final _read = context.read<CartListProvider>();
    final _addProcutRead = context.read<AddingCardProvider>();
    int productCount = _read.cartList[index].amount!;
    final productPrice = _read.cartList[index].productPrice!;
    if (productCount == 1) {
      AllServices.deleteFromCart(
          context, _read.cartList[index].productId.toString());
    } else {
      productCount--;
      await _addProcutRead.addingToCard(
        productId: _read.cartList[index].productId!,
        productCount: productCount,
        context: context,
      );
      _read.fetchProductsOnCard();
    }
    // sum += productPrice;

    // Navigator.pop(context);
    incrementLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DeliveryPriceProvider>().resetPrice(0);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorPalatte.mainPageColor,
        body: SafeArea(
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Consumer4<CartListProvider, OrderProcessProvider,
                AddingCardProvider, DeliveryPriceProvider>(
              builder: (context, cartList, orderProcess, addProduct,
                  deliveryPrice, child) {
                return cartList.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : cartList.cartList.isNotEmpty
                        ? SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Header(
                                  icon1Url: 'assets/icons/Icon-left.svg',
                                  title: 'cart'.tr,
                                  onpress1: () {
                                    Get.back();
                                    context
                                        .read<DeliveryPriceProvider>()
                                        .resetPrice(0);
                                  },
                                  icon2Url: 'assets/icons/close.svg',
                                  onpress2: () {
                                    Get.back();
                                    context
                                        .read<DeliveryPriceProvider>()
                                        .resetPrice(0);
                                  },
                                  height2: 18,
                                  height1: 14,
                                  width1: 14,
                                  width2: 18,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RadioListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          dense: true,
                                          activeColor: const Color(0xff9F111B),
                                          value: 1,
                                          groupValue: selectedRadio,
                                          onChanged: (int? val) {
                                            orderProcess.changeDeliveryType(12);
                                            print(val);
                                            setState(() {
                                              selectedRadioValue(val);
                                            });
                                          },
                                          title: Text(
                                            'deliveryPrice'.tr,
                                            // delivertyTypeController.deliveryTypeList[0].name,
                                            style: FontStyles.semiBoldStyle(
                                              fontSize: 21,
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xff171101),
                                            ),
                                          ),
                                        ),
                                        RadioListTile(
                                          dense: true,
                                          activeColor: const Color(0xff9F111B),
                                          value: 2,
                                          groupValue: selectedRadio,
                                          onChanged: (int? val) {
                                            orderProcess.changeDeliveryType(13);
                                            print(val);
                                            setState(() {
                                              selectedRadioValue(val);
                                              deliveryPrice.resetPrice(0);
                                              addressController.text = '';
                                              addressLatLng = null;
                                              lat = 0.0;
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          title: Text(
                                            'takeMySelf'.tr,
                                            // delivertyTypeController.deliveryTypeList[1].name,
                                            style: FontStyles.semiBoldStyle(
                                              fontSize: 21,
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xff171101),
                                            ),
                                          ),
                                        ),
                                        selectedRadio == 1
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 26),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 30),
                                                        child: Text(
                                                          'deliveryAddress'.tr,
                                                          style: FontStyles
                                                              .mediumStyle(
                                                            fontSize: 21,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: const Color(
                                                                0xff171101),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 20,
                                                            top: 30),
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    addressController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .requestFocus(
                                                                              FocusNode());
                                                                      dynamic
                                                                          result =
                                                                          await Get.to(
                                                                              MapScreen());
                                                                      if (result !=
                                                                          null) {
                                                                        addressController
                                                                          ..text =
                                                                              result['address'] ?? '';

                                                                        setState(
                                                                            () {
                                                                          lat =
                                                                              result['position'].latitude;
                                                                          lng =
                                                                              result['position'].longitude;

                                                                          addressLatLng =
                                                                              '$lat, $lng';
                                                                          finalPrice =
                                                                              deliveryPrice.price + cartList.totalSum;
                                                                        });
                                                                      }
                                                                      print(
                                                                          'pressing location icon');
                                                                    },
                                                                  ),
                                                                  hintText:
                                                                      'ул. Умарова, д.18',
                                                                  hintStyle:
                                                                      FontStyles
                                                                          .regularStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: const Color(
                                                                        0xff0E0900),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15.0),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Colors
                                                                          .transparent,
                                                                    ),
                                                                  ),
                                                                ),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              )
                                            : Container()
                                      ]),
                                ),

                                ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: cartList.cartList.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemBuilder: (context, index) {
                                      return Stack(children: [
                                        Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: SizedBox(
                                                    child: Image.network(
                                                        'http://hamd.loko.uz/' +
                                                            cartList
                                                                .cartList[index]
                                                                .productPhoto!),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                            height: 35),
                                                        Text(
                                                          cartList
                                                                      .cartList[
                                                                          index]
                                                                      .productName!
                                                                      .length >
                                                                  15
                                                              ? cartList
                                                                      .cartList[
                                                                          index]
                                                                      .productName!
                                                                      .substring(
                                                                          0,
                                                                          15) +
                                                                  '...'
                                                              : cartList
                                                                  .cartList[
                                                                      index]
                                                                  .productName!,
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              cartList
                                                                  .cartList[
                                                                      index]
                                                                  .productPrice
                                                                  .toString(),
                                                              style: FontStyles
                                                                  .semiBoldStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: const Color(
                                                                    0xff222E54),
                                                              ),
                                                            ),
                                                            Row(children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  decrement(
                                                                      index);
                                                                },
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/minus.svg',
                                                                  height: 25,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                cartList
                                                                    .cartList[
                                                                        index]
                                                                    .amount
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  incrment(
                                                                      index);
                                                                },
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/plus.svg',
                                                                  height: 27,
                                                                ),
                                                              )
                                                            ]),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 20,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () async {
                                                await AllServices
                                                    .deleteFromCart(
                                                        context,
                                                        cartList.cartList[index]
                                                            .productId
                                                            .toString());
                                                await cartList
                                                    .fetchProductsOnCard();
                                                // fetchDataa();
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: ColorPalatte
                                                      .strongRedColor),
                                            ))
                                      ]);
                                    }),

                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.86,
                                    height: selectedRadio == 2 ? 110 : 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 29,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'foodPrice'.tr,
                                              style: FontStyles.mediumStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff494D6D),
                                              ),
                                            ),
                                            Text(
                                              '${cartList.totalSum}',
                                              style: FontStyles.mediumStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff494D6D),
                                              ),
                                            ),
                                          ],
                                        ),
                                        selectedRadio == 2
                                            ? Container()
                                            : const SizedBox(
                                                height: 13,
                                              ),
                                        selectedRadio == 2
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'deliveryPrice'.tr,
                                                    style:
                                                        FontStyles.mediumStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Montserrat',
                                                      color: const Color(
                                                          0xff494D6D),
                                                    ),
                                                  ),
                                                  deliveryPrice.isLoading
                                                      ? const Text('0')
                                                      : Text(
                                                          deliveryPrice.price
                                                              .toString(),
                                                          style: FontStyles
                                                              .mediumStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: const Color(
                                                                0xff494D6D),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'totalPrice'.tr,
                                              style: FontStyles.semiBoldStyle(
                                                fontSize: 18,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff9F111B),
                                              ),
                                            ),
                                            selectedRadio == 2
                                                ? Text(
                                                    '${cartList.totalSum}',
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Montserrat',
                                                      color: const Color(
                                                          0xff9F111B),
                                                    ),
                                                  )
                                                : Text(
                                                    cartList
                                                        .sumFoodAndDeliveryFunction(
                                                            cartList.totalSum,
                                                            deliveryPrice.price)
                                                        .toString(),
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Montserrat',
                                                      color: const Color(
                                                          0xff9F111B),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                // BillScreen(
                                //     selectedIndex: selectedRadio,
                                //     orders: cartList.cartList),
                                const SizedBox(height: 16),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.86,
                                    height: 63,
                                    child: RaisedButton(
                                      elevation: 0,
                                      color: Color(0xff9F111B),
                                      onPressed: () {
                                        if (selectedRadio == 1 && lat == 0.0) {
                                          Get.dialog(GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Scaffold(
                                              backgroundColor:
                                                  Colors.black.withOpacity(.1),
                                              body: Center(
                                                child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    color: Colors.white,
                                                    width: double.infinity,
                                                    // height: 140.0,
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(
                                                                height: 10),
                                                            const SizedBox(
                                                                height: 20),
                                                            Text(
                                                                'pleaseChooseAddress'
                                                                    .tr,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            const SizedBox(
                                                                height: 30),
                                                          ],
                                                        ),
                                                        Positioned(
                                                          top: 15,
                                                          right: 0,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Icon(
                                                                Icons.cancel,
                                                                color: ColorPalatte
                                                                    .strongRedColor,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ));
                                        } else {
                                          Get.to(
                                            () => PaymentScreen(
                                                selectedIndex: selectedRadio,
                                                address: selectedRadio == 1
                                                    ? addressController.text
                                                    : 'takeMySelf'.tr,
                                                addressLatLng: selectedRadio ==
                                                        1
                                                    ? addressLatLng.toString()
                                                    : '0.0, 0.0',
                                                orders: cartList.cartList),
                                            // arguments: [
                                            //   selectedRadio,
                                            //   selectedRadio == 1
                                            //       ? addressController.text
                                            //       : 'takeMySelf'.tr,
                                            //   selectedRadio == 1
                                            //       ? addressLatLng.toString()
                                            //       : '0.0, 0.0',
                                            // ],
                                          );
                                        }
                                        print('in custom radio dart');
                                        print(selectedRadio);

                                        // Get.to(PaymentScreen(), arguments: [
                                        //   selectedRadio,
                                        //   selectedRadio == 1
                                        //       ? addressController.text
                                        //       : 'takeMySelf'.tr,
                                        //   selectedRadio == 1
                                        //       ? addressLatLng.toString()
                                        //       : '0.0, 0.0',
                                        // ]);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        'orderButton'.tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                FontPalatte.nextButtonSize),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 500,
                            child: Column(children: [
                              Header(
                                icon1Url: 'assets/icons/Icon-left.svg',
                                title: 'cart'.tr,
                                onpress1: () => Get.back(),
                                icon2Url: 'assets/icons/close.svg',
                                onpress2: () => Get.back(),
                                height2: 18,
                                height1: 14,
                                width1: 14,
                                width2: 18,
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text('youHaveNotOrdersYet'.tr),
                                ),
                              ),
                            ]),
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
