import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/adding_card_provider.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/product_detail_provider.dart';
import 'package:hamd_user/screens/cart/cart_screen.dart';
import 'package:hamd_user/screens/components/food_detail_appbar.dart';
import 'package:hamd_user/screens/food_detail/widgets/food_description.dart';
import 'package:hamd_user/screens/food_detail/widgets/rating_and_time.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer3<ProductDetailProvdier, CartListProvider,
        AddingCardProvider>(
      builder: (context, proDetail, cartList, addingCard, child) {
        final foodDescription =
            proDetail.productDetail?.description!.replaceAll('&#39;', '\'');
        return Scaffold(
          appBar: PreferredSize(
            child: foodDetailAppBar(
              context,
              isCart: true,
              icon1Url: 'assets/icons/Icon-left.svg',
              height1: 14,
              width1: 14,
              onpress1: () => Get.back(),
              title: proDetail.productDetail?.name ?? '',
              productsOnList: cartList.cartList.length,
              // title: productByCategoryController
              //     .productByCategoryList[recievedIndex].name,
              // title: productByCategoryController
              //             .productByCategoryList[recievedIndex].name.length >
              //         16
              //     ? productByCategoryController
              //         .productByCategoryList[recievedIndex].name
              //         .substring(0, 15)
              //     : productByCategoryController
              //         .productByCategoryList[recievedIndex].name,
              icon2Url: 'assets/icons/shopping-cart.svg',
              width2: 25,
              height2: 25,
              onpress2: () => Get.to(() => const CartScreen()),
            ),
            preferredSize: Size.fromHeight(
                kToolbarHeight + MediaQuery.of(context).viewPadding.top),
          ),
          backgroundColor: ColorPalatte.mainPageColor,
          body: proDetail.isLoading || cartList.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const SizedBox(height: 7),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 70),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'http://hamd.loko.uz/' +
                                        proDetail.productDetail!.photo!,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 30),
                                    child: Column(
                                      children: [
                                        RatingAndItem(),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'foodDes'.tr,
                                            style: FontStyles.mediumStyle(
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              color: const Color(0xff222E54),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          child: ItemDescription(
                                            foodDes:
                                                // '${productByCategoryController.productByCategoryList[recievedIndex].description}',
                                                foodDescription ?? '',
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Spacer(),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'price'.tr,
                                                    style:
                                                        FontStyles.mediumStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${proDetail.productDetail!.price}'
                                                            ' ' +
                                                        'sum'.tr,
                                                    style:
                                                        FontStyles.regularStyle(
                                                      fontSize: 26,
                                                      fontFamily: 'Poppins',
                                                      color: const Color(
                                                          0xff222E54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Consumer<AddingCardProvider>(
                                                builder:
                                                    (context, adding, child) {
                                                  return GestureDetector(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: adding.isLoading
                                                          ? const CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                ColorPalatte
                                                                    .strongRedColor,
                                                              ),
                                                            )
                                                          : SvgPicture.asset(
                                                              'assets/icons/plus.svg',
                                                              width: 50,
                                                              height: 50,
                                                            ),
                                                    ),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AddingCardProvider>()
                                                          .addingToCard(
                                                              context: context,
                                                              productCount:
                                                                  count,
                                                              productId: proDetail
                                                                  .productDetail!
                                                                  .id!);

                                                      // counterState.onFetching();

                                                      // int amount = counterClass.count.value;

                                                      // print(productByCategoryController
                                                      //     .productByCategoryList[
                                                      //         recievedIndex]
                                                      //     .id);
                                                      // print('amount');

                                                      // AddCartPostService.addCartPostService(
                                                      //     amount: count,
                                                      //     productId:
                                                      //         productByCategoryController
                                                      //             .productByCategoryList[
                                                      //                 recievedIndex]
                                                      //             .id);
                                                      // Get.to(CartScreen());
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // ItemPosition(),
                                Positioned(
                                  top: -20.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 129.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff9F111B),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      if (count > 1) {
                                                        setState(() {
                                                          count--;
                                                        });
                                                        print(count);
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                    ),
                                                    color:
                                                        const Color(0xff9F111B),
                                                  ),
                                                ),
                                                Text(
                                                  count.toString(),
                                                  // count.toString(),
                                                  style: FontStyles.mediumStyle(
                                                    fontSize: 24,
                                                    fontFamily: 'Poppins',
                                                    color:
                                                        const Color(0xffFFFFFF),
                                                  ),
                                                ),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        count++;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 16,
                                                    ),
                                                    color:
                                                        const Color(0xff9F111B),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
