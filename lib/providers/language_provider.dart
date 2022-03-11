import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/providers/adding_card_provider.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/category_provder.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';
import 'package:hamd_user/providers/product_detail_provider.dart';
import 'package:provider/provider.dart';

class LanguageProvider extends ChangeNotifier {
  void changeLanguage(BuildContext context, var param1, var param2) async {
    var locale = Locale(param1, param2);
    // final _read = context.read<CategoryProvider>();
    // await _read.fetchAllCategories(context);
    // context
    //     .read<ProductsByCategoryProvider>()
    //     .fetchProductsByCategory(_read.categoryId);

    // context.read<ProductDetailProvdier>().fetchProductDetail(id)
    // await context.read<CategoryProvider>().fetchAllCategories(context);
    // print('the lang id');
    // print(_read.categoryId);
    // context
    //     .read<ProductsByCategoryProvider>()
    //     .fetchProductsByCategory(_read.categoryId);
    // context.read<CartListProvider>().fetchProductsOnCard();

    Get.updateLocale(locale);
    notifyListeners();
  }
}
