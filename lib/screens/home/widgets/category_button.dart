import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/category_provder.dart';
import 'package:provider/provider.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ourMenu'.tr,
            style: FontStyles.mediumStyle(
              fontSize: 18,
              fontFamily: 'Poppins', //looked really strange with this style
              color: const Color(0xff222E54),
            ),
          ),
        ),
      ),
      const SizedBox(height: 25),
      Consumer<CategoryProvider>(
        builder: (context, allCategories, child) {
          return allCategories.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allCategories.allCategories.length,
                    itemBuilder: (context, index) => Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(left: 25)
                          : const EdgeInsets.only(left: 13),
                      child: RaisedButton(
                        elevation: 0,
                        color: allCategories.categoryId ==
                                allCategories.allCategories[index].id
                            ? ColorPalatte.strongRedColor
                            : Colors.white,
                        onPressed: () {
                          allCategories.categoryChanger(context,
                              allCategories.allCategories[index].id!, true);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          allCategories.allCategories[index].name!,
                          style: FontStyles.mediumStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: allCategories.categoryId ==
                                    allCategories.allCategories[index].id
                                ? Colors.white
                                : const Color(0xff222E54),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      )
    ]);
  }
}
