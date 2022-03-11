import 'package:flutter/material.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/models/category_model.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';
import 'package:provider/provider.dart';

class CategoryProvider extends ChangeNotifier {
  bool isLoading = true;
  int categoryId = 0;
  List<Data> allCategories = [];

  categoryChanger(BuildContext context, int id, bool isAllowed) {
    categoryId = id;
    if (isAllowed)
      context.read<ProductsByCategoryProvider>().fetchProductsByCategory(id);
    notifyListeners();
  }

  Future<void> fetchAllCategories(BuildContext context,
      {bool isAllowed = true}) async {
    try {
      var response = await AllServices.fetchCategories();
      if (response != null) {
        var id = response.data?.first.id;
        if (id != null) {
          categoryChanger(context, id, isAllowed);
        }
        allCategories = response.data ?? [];
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
