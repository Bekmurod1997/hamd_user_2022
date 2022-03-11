import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/api.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/models/adding_card_model.dart';
import 'package:hamd_user/models/cart_list_model.dart';
import 'package:hamd_user/models/category_model.dart';
import 'package:hamd_user/models/code_confirm_model.dart';
import 'package:hamd_user/models/delivery_price_model.dart';
import 'package:hamd_user/models/my_orders_model.dart';
import 'package:hamd_user/models/plastic_card_model.dart';
import 'package:hamd_user/models/plastic_card_verified_model.dart';
import 'package:hamd_user/models/product_detail_model.dart';
import 'package:hamd_user/models/products_by_category_model.dart';
import 'package:hamd_user/models/signin_model.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/screens/auth/singup/verify_number_screen.dart';
import 'package:hamd_user/screens/home/home_screen.dart';
import 'package:hamd_user/utils/my_prefs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AllServices {
  static var client = http.Client();

  static Future<void> payBill(
      {required String id, required String cardId}) async {
    final token = MyPref.secondToken;
    try {
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/order/pay-receipt'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {
          'order_receipt_id': id,
          'card_id': cardId,
        },
      );
      if (response.statusCode == 200) {
        print('succress in payingBill');
        Get.snackbar(
          "successPayingBill".tr,
          "",
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          // dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {
        Get.snackbar(
          "notEnoughtMoney".tr,
          "",
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          // dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        print('else statment in payBill');
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print('error in payBill method');
      print(e);
    }
  }

  static Future<void> rateFood(List<String> foodIds, String ratingValue) async {
    final token = MyPref.secondToken;
    var data = <String, String>{};

    try {
      for (var i = 0; i < foodIds.length; i++) {
        data.addAll({'product_id[$i]': foodIds[i]});
      }
      for (var i = 0; i < foodIds.length; i++) {
        data.addAll({'rating[$i]': ratingValue});
      }

      for (var i = 0; i < data.length; i++) {
        print(data['product_id[$i]']);
        print(data['rating[$i]']);
      }

      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/product/set-rating'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: data,
      );
      if (response.statusCode == 200) {
        print('success in rating');
        Get.back();
      } else {
        Get.back();
        print('else statement in rating');
      }
    } catch (e) {
      print('error in rating food');
      print(e);
      Get.back();
    }
  }

  static Future<void> rateDriver(String driverId, String rating) async {
    final token = MyPref.secondToken;

    try {
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/user/set-rating'),
        body: {
          'courier_id': driverId,
          'rating': rating,
        },
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('success in driver rate');
        Get.back();
      } else {
        Get.back();
      }
    } catch (e) {
      print('error in rating driver');
      print(e);
      Get.back();
    }
  }

  static Future<void> editProfile(String? name, String? photo) async {
    final token = MyPref.secondToken;
    try {
      var response = await client.post(
        Uri.parse(ApiUrl.updateProfile),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {},
      );
    } catch (e) {
      print('error in  editing profie ');
      print(e);
    }
  }

  static Future<void> deletePlasticCard(
      BuildContext context, String plasticCardId) async {
    final token = MyPref.secondToken;
    try {
      var response = await client.delete(
        Uri.parse('http://hamd.loko.uz/api/card/remove'),
        body: {
          'card_id': plasticCardId,
        },
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        context.read<PlasticCardProvider>().fetchPlasticCard();
        Get.back();
      }
    } catch (e) {
      print('error in deleting plastic card');
      print(e);
    }
  }

  static Future<PlasticCardVerifiedModel?> addPlasticCard(
      {required BuildContext context,
      required int typeId,
      required String cardNumber,
      required String cardPhoneNumber,
      required String cardExpire}) async {
    final token = MyPref.secondToken;

    try {
      print('before seding plastic card data');
      print(typeId);
      print(cardNumber);
      print(cardPhoneNumber);
      print(cardExpire);
      TextEditingController verifyNumber = TextEditingController();
      var response = await client
          .post(Uri.parse('http://hamd.loko.uz/api/card/send'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }, body: {
        'type_id': typeId.toString(),
        'card_number': cardNumber,
        'card_phone_number': cardPhoneNumber,
        'card_expire': cardExpire,
      });
      print('------');

      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString =
            PlasticCardVerifiedModel.fromJson(json.decode(response.body));

        print('the id of plastic card recieved');
        print(jsonString.data);
        MyPref.plasticCardId = jsonString.data!.id.toString();
        Get.back();
        Get.bottomSheet(
          StatefulBuilder(
            builder: (context, state) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'enterCode'.tr,
                        style: FontStyles.mediumStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff0E0E0E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffE1E1E1),
                            )),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: verifyNumber,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          print('verift button pressed');
                          try {
                            print('this is sending plastic card id to verify');
                            print(MyPref.plasticCardId);
                            var res2 = await client.post(
                              Uri.parse(
                                  'http://hamd.loko.uz/api/card/send-verify-code'),
                              body: {
                                'card_id': MyPref.plasticCardId,
                                'code': verifyNumber.text,
                              },
                              headers: {
                                HttpHeaders.authorizationHeader: 'Bearer $token'
                              },
                            );
                            print(res2.request);
                            if (res2.statusCode == 200) {
                              context
                                  .read<PlasticCardProvider>()
                                  .fetchPlasticCard();
                              Get.back();
                              Get.snackbar(
                                "successSavingCard".tr,
                                "",
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                borderRadius: 20,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: Duration(seconds: 4),
                                isDismissible: true,
                                // dismissDirection: SnackDismissDirection.HORIZONTAL,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            }
                          } catch (e) {
                            print('error in sending verification numbre');
                            print(e);
                          }
                        },
                        child: Text('verify'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print('error in adding plastic card');
      print(e);
    }
  }

  static Future<PlaticCardTypeModel?> fetchMyPlasticCard() async {
    final token = MyPref.secondToken;
    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/card'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var jsonString =
            PlaticCardTypeModel.fromJson(json.decode(response.body));
        return jsonString;
      } else {
        print('this is else statement in plastic card');
        print(response.statusCode);
      }
    } catch (e) {
      print('error in fetching plastic card');
      print(e);
    }
  }

  static Future makeOrder(
      {String? address,
      String? location,
      required int deliveryType,
      required int paymentType}) async {
    final token = MyPref.secondToken;
    try {
      print('http://hamd.loko.uz/api/order/send');
      print(
          'address $address map_location $location payment_type_id $paymentType delivery_type_id $deliveryType');
      var response = await client
          .post(Uri.parse('http://hamd.loko.uz/api/order/send'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Accept': 'application/json'
      }, body: {
        'address': address,
        'map_location': location,
        'comment': 'Хорошего вам дня!',
        'payment_type_id': paymentType.toString(),
        'delivery_type_id': deliveryType.toString(),
      });
      print(response.request);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.request);
        print(response.body);
        Get.offAll(() => const HomeScreen());
      }
    } catch (e) {
      print('error in ordering');
      print(e);
    }
  }

  static Future<DeliveryPriceModel?> fetchDeliveryPrice(
      BuildContext context, String latLng) async {
    final token = MyPref.secondToken;
    try {
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/order/delivery-price'),
        body: {
          'map_location': latLng,
        },
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('succes in delivery price');
        var jsonString =
            DeliveryPriceModel.fromJson(json.decode(response.body));
        return jsonString;
      }
    } catch (e) {
      print('error in price delivery');
      print(e);
    }
  }

  static Future<MyOrdersModel?> fetchMyOrder() async {
    final token = MyPref.secondToken;
    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/order'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('succes in fetching my orders');
        var jsonString = MyOrdersModel.fromJson(json.decode(response.body));
        return jsonString;
      }
    } catch (e) {
      print('error in fetching my orders');
      print(e);
    }
  }

  static Future deleteFromCart(BuildContext context, String productId) async {
    final token = MyPref.secondToken;
    try {
      var response = await client.post(
          Uri.parse('http://hamd.loko.uz/api/cart/remove'),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          body: {'product_id': productId});
      if (response.statusCode == 200) {
        print('success in deleting from cart');
        context.read<CartListProvider>().fetchProductsOnCard();
      }
    } catch (e) {
      print('error in deleing from cart');
      print(e);
    }
  }

  static Future<AddingCardModel?> addProductToCard(
      {required int productId,
      required int productCount,
      required BuildContext context}) async {
    final token = MyPref.secondToken;

    try {
      var response = await client
          .post(Uri.parse('http://hamd.loko.uz/api/cart/send'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Language': MyPref.lang == '' ? 'ru' : MyPref.lang,
      }, body: {
        'product_id': productId.toString(),
        'amount': productCount.toString(),
      });
      if (response.statusCode == 200) {
        print('success in adding to card');
        var jsonString = AddingCardModel.fromJson(json.decode(response.body));

        context.read<CartListProvider>().fetchProductsOnCard();
        return jsonString;
      }
    } catch (e) {
      print('error in adding to card');
      print(e);
    }
  }

  static Future<CartListModel?> fetchProductOnCart() async {
    final token = MyPref.secondToken;
    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/cart'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Language': MyPref.lang == '' ? 'ru' : MyPref.lang,
        },
      );
      if (response.statusCode == 200) {
        print('success in fetching products in cart');
        var jsonString = CartListModel.fromJson(json.decode(response.body));
        return jsonString;
      }
    } catch (e) {
      print('error in fetchingCartList');
      print(e);
    }
  }

  static Future<ProductsDetailModel?> fetchProductDetail(int id) async {
    final languageToken = MyPref.lang;
    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/product/view?id=$id'),
        headers: {
          'Content-Language': MyPref.lang == '' ? 'ru' : MyPref.lang,
          // 'Content-Language': MyPref.lang,
        },
      );
      if (response.statusCode == 200) {
        var jsonString =
            ProductsDetailModel.fromJson(json.decode(response.body));
        return jsonString;
      }
    } catch (e) {
      print('error in product detail');
      print(e);
    }
  }

  static Future<ProductsByCategoryModel?> fetchProductsByCategory(
      int id) async {
    print('the language:');
    print(MyPref.lang);
    // try {
    var response = await client.get(
      Uri.parse('http://hamd.loko.uz/api/product?category_id=$id'),
      headers: {
        'Content-Language': MyPref.lang == '' ? 'ru' : MyPref.lang,
        // 'Content-Language': MyPref.lang,
      },
    );
    print(response);
    if (response.statusCode == 200) {
      var jsonString =
          ProductsByCategoryModel.fromJson(json.decode(response.body));
      return jsonString;
    }
    // } catch (e) {
    //   print(e);
    //   print('error in fetching products by category');
    // }
  }

  static Future<CategoryModel?> fetchCategories() async {
    final token = MyPref.secondToken;
    try {
      var response = await client.get(
        Uri.parse(ApiUrl.productType),
        headers: {
          'Content-Language': MyPref.lang == '' ? 'ru' : MyPref.lang,
          // 'Content-Language': '$languageToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonString = CategoryModel.fromJson(json.decode(response.body));
        return jsonString;
      }
    } catch (e) {
      print('error in fetching categories');
      print(e);
    }
  }

  static Future<CodeConfirmModel?> fetchProfileInfo() async {
    final token = MyPref.secondToken;
    try {
      var response = await client.get(
        Uri.parse(ApiUrl.profile),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var body = CodeConfirmModel.fromJson(json.decode(response.body));
        print('User Data: ${response.body}');
        return body;
      } else {
        print('else statement in userFetch');
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('error in userFetch');
      print(e);
    }
  }

  static Future<CodeConfirmModel?> codeConfirm(
      {String? code, String? fcmToken}) async {
    final token = MyPref.token;

    try {
      var response = await client.post(
        Uri.parse(ApiUrl.sendSmsCode),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {
          'code': code,
        },
      );
      if (response.statusCode == 200) {
        var body = CodeConfirmModel.fromJson(json.decode(response.body));
        print('confrim token');
        print(response.body);
        MyPref.secondToken = body.data!.token!;
        print('token after confirm');
        print(MyPref.secondToken);
        Get.offAll(() => const HomeScreen());
        // pController.fetchProfileData();
        // categoryData.fetchCategories();
        // productByCategoryController.fetchProductByCategory(28);
        return body;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('error in codeconfirm');
      print(e);
    }
  }

  static Future<SignInModel?> signInUser(
      {String? userNumber, String? fcmToken}) async {
    try {
      var response = await client.post(Uri.parse(ApiUrl.signIn), body: {
        'phone': userNumber,
        'role': '3',
        'device_token': fcmToken ?? '',
      });
      if (response.statusCode == 200) {
        var body = SignInModel.fromJson(json.decode(response.body));
        MyPref.token = body.data!.token!;
        MyPref.code = body.data!.code!.code!;
        MyPref.phoneNumber = body.data!.code!.phone!;
        print('saved token');
        print(MyPref.token);
        Get.back();
        Get.to(() => VerifyNumberScreen());
      }
    } catch (e) {
      print('error in signInservice');
      print(e);
    }
  }
}
