import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/product_detail_provider.dart';
import 'package:hamd_user/screens/food_detail/food_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<ProductsByCategoryProvider>(
      builder: (context, productByCategory, child) {
        return productByCategory.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 400.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productByCategory.allProducts.length,
                  itemBuilder: (contet, index) {
                    String productName =
                        productByCategory.allProducts[index].name!;
                    var myArr = productName.split(' ');
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const FoodDetailScreen());
                        context
                            .read<ProductDetailProvdier>()
                            .fetchProductDetail(
                                productByCategory.allProducts[index].id!);
                        context.read<CartListProvider>().fetchProductsOnCard();
                      },
                      child: Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(left: 24, right: 13)
                            : const EdgeInsets.only(right: 23),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          width: productByCategory.allProducts.length == 1
                              ? screenSize.width * 0.88
                              : screenSize.width * 0.86,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: screenSize.width * 0.76,
                                      height: screenSize.height * 0.23,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: const Color(0xffEDF0F3),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              'http://hamd.loko.uz/' +
                                                  productByCategory
                                                      .allProducts[index]
                                                      .photo!,
                                            ),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 15,
                                      child: Container(
                                        height: 35,
                                        width: 52,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text('5.0'),
                                            const SizedBox(width: 3.0),
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                              width: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (myArr.length == 1)
                                              Text(
                                                myArr[0],
                                                style: FontStyles.semiBoldStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Ubuntu',
                                                  color:
                                                      const Color(0xff222E54),
                                                ),
                                              ),
                                            if (myArr.length == 2 &&
                                                myArr[0].length <= 8 &&
                                                myArr[1].length <= 8)
                                              Text(
                                                productByCategory
                                                    .allProducts[index].name!,
                                                style: FontStyles.semiBoldStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Ubuntu',
                                                  color:
                                                      const Color(0xff222E54),
                                                ),
                                              ),
                                            if (myArr.length == 2 &&
                                                (myArr[0].length > 8 ||
                                                    myArr[1].length > 8))
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    myArr[0],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[1],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (myArr.length == 3)
                                              myArr[0].length < 8 ||
                                                      myArr[1].length < 8
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          myArr[0] +
                                                              ' ' +
                                                              myArr[1],
                                                          style: FontStyles
                                                              .semiBoldStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            color: const Color(
                                                                0xff222E54),
                                                          ),
                                                        ),
                                                        Text(
                                                          myArr[2],
                                                          style: FontStyles
                                                              .semiBoldStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            color: const Color(
                                                                0xff222E54),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          myArr[0],
                                                          style: FontStyles
                                                              .semiBoldStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            color: const Color(
                                                                0xff222E54),
                                                          ),
                                                        ),
                                                        Text(
                                                          myArr[1] +
                                                              ' ' +
                                                              myArr[2],
                                                          style: FontStyles
                                                              .semiBoldStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Ubuntu',
                                                            color: const Color(
                                                                0xff222E54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            if (myArr.length == 4)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    myArr[0] + ' ' + myArr[1],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[2] + ' ' + myArr[3],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (myArr.length == 5)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    myArr[0] + ' ' + myArr[1],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[2] + ' ' + myArr[3],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[4],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (myArr.length == 6)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    myArr[0] + ' ' + myArr[1],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[2] + ' ' + myArr[3],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  Text(
                                                    myArr[4] + ' ' + myArr[5],
                                                    style: FontStyles
                                                        .semiBoldStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Ubuntu',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                        Text(
                                          productByCategory
                                                  .allProducts[index].price
                                                  .toString() +
                                              ' ' +
                                              'sum'.tr,
                                          style: FontStyles.semiBoldStyle(
                                            fontSize: 16,
                                            fontFamily: 'Ubuntu',
                                            color: const Color(0xffA01721),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      child: Text(
                                        productByCategory
                                            .allProducts[index].description!,
                                        style: FontStyles.semiBoldStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xffA4ABB9),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/deliver.svg'),
                                        const SizedBox(width: 5),
                                        Text(
                                          'От 10 000 ' + 'sum'.tr,
                                          style: FontStyles.regularStyle(
                                            fontSize: 11,
                                            fontFamily: 'Ubuntu',
                                            color: const Color(0xff494D6D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/clock.svg'),
                                        const SizedBox(width: 5),
                                        Text(
                                          '10-15 ' + 'minutes'.tr,
                                          style: FontStyles.regularStyle(
                                            fontSize: 11,
                                            fontFamily: 'Ubuntu',
                                            color: const Color(0xff494D6D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/plus.svg',
                                          width: 35,
                                          height: 35,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
      },
    );
  }
}
