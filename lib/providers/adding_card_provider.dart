import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/adding_card_model.dart';

class AddingCardProvider extends ChangeNotifier {
  bool isLoading = false;
  Data? addingCard;
  Future<void> addingToCard(
      {required int productId,
      required int productCount,
      required BuildContext context}) async {
    try {
      isLoading = true;
      notifyListeners();
      var response = await AllServices.addProductToCard(
          context: context, productId: productId, productCount: productCount);
      addingCard = response?.data;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
