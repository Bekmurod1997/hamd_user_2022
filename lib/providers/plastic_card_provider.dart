import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/plastic_card_model.dart';

class PlasticCardProvider extends ChangeNotifier {
  List<Data> myPlastic = [];
  bool isLoading = true;

  Future<void> fetchPlasticCard() async {
    try {
      var response = await AllServices.fetchMyPlasticCard();
      myPlastic = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
