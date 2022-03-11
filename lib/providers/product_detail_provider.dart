import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/product_detail_model.dart';

class ProductDetailProvdier extends ChangeNotifier {
  bool isLoading = true;

  Data? productDetail;

  void fetchProductDetail(int id) async {
    try {
      var respone = await AllServices.fetchProductDetail(id);
      productDetail = respone?.data;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
