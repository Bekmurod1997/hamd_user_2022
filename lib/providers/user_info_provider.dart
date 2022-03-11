import 'package:flutter/material.dart';
import 'package:hamd_user/models/code_confirm_model.dart';
import 'package:hamd_user/apiservices/all_services.dart';

class UserInfoProvider extends ChangeNotifier {
  Data? userData;
  String? imageAvatar;
  bool isLoading = true;

  void imageAvatarChanger(BuildContext context, String? image) {
    imageAvatar = image;
    print(imageAvatar);
    notifyListeners();
  }

  void fetchUserInfo() async {
    try {
      var response = await AllServices.fetchProfileInfo();
      userData = response?.data;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
