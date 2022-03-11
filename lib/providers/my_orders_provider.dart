import 'package:flutter/material.dart';
import 'package:hamd_user/models/my_orders_model.dart';
import 'package:hamd_user/apiservices/all_services.dart';

class MyOrdersProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Data> myOrders = [];

  Future<void> fetchMyOrders() async {
    try {
      var response = await AllServices.fetchMyOrder();
      myOrders = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
