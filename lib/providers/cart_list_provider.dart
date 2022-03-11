import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/cart_list_model.dart';

class CartListProvider extends ChangeNotifier {
  bool isLoading = true;
  int totalSum = 0;
  int sumFoodAndDelivery = 0;
  List<Data> cartList = [];

  int sumFoodAndDeliveryFunction(int totalFood, int deliveryPrice) {
    return totalFood + deliveryPrice;
  }

  Future<void> fetchProductsOnCard() async {
    try {
      var response = await AllServices.fetchProductOnCart();
      cartList = response?.data ?? [];

      if (cartList.isNotEmpty) {
        totalSum = 0;
        for (var i = 0; i < cartList.length; i++) {
          totalSum = totalSum + cartList[i].totalPrice!;
        }
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
