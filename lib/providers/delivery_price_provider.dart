import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/delivery_price_model.dart';

class DeliveryPriceProvider extends ChangeNotifier {
  bool isLoading = true;

  int price = 0;

  Data? myLocation;

  void resetPrice(int val) {
    price = val;
    notifyListeners();
  }

  void fetchDeliveryPrice(BuildContext context, String latLng) async {
    try {
      var resposne = await AllServices.fetchDeliveryPrice(context, latLng);

      myLocation = resposne?.data;
      price = resposne?.data?.deliveryPrice ?? 0;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
