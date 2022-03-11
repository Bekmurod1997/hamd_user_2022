import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/products_by_category_model.dart';

class ProductsByCategoryProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Data> allProducts = [];

  void fetchProductsByCategory(int id) async {
    try {
      var response = await AllServices.fetchProductsByCategory(id);
      allProducts = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
