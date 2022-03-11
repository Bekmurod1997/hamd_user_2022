import 'package:flutter/material.dart';
import 'product_detail_provider.dart';

class OrderProcessProvider extends ChangeNotifier {
  int deliveryType = 12;

  int paymentType = 16;
  void changeDeliveryType(int index) {
    deliveryType = index;
    print('delivery type: $deliveryType');
    notifyListeners();
  }

  void changePaymentType(int index) {
    paymentType = index;
    print('paymentType: $paymentType');
    notifyListeners();
  }
}
