import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/screens/auth/singup/auth_screen.dart';
import 'package:hamd_user/screens/components/my_appbar.dart';

class StaticPageScreen extends StatefulWidget {
  const StaticPageScreen({Key? key}) : super(key: key);

  @override
  State<StaticPageScreen> createState() => _StaticPageScreenState();
}

class _StaticPageScreenState extends State<StaticPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      appBar: PreferredSize(
          child: customAppBar(context,
              isCart: true,
              icon1Url: 'assets/icons/drawer.svg',
              height1: 10,
              width1: 10,
              onpress1: () => Get.to(() => AuthScreen()),
              title: 'mainMeny',
              icon2Url: 'assets/icons/shopping-cart.svg',
              width2: 25,
              height2: 25,
              onpress2: () => Get.to(() => const AuthScreen()),
              productsOnList: 0),
          preferredSize: Size.fromHeight(
              kToolbarHeight + MediaQuery.of(context).viewPadding.top)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _UserWelcome(),
                      SizedBox(height: 20),
                      CategoryButton(),
                      SizedBox(height: 20),
                      _FoodCardWidget(),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCardWidget extends StatelessWidget {
  const _FoodCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final allFoodTitle = [
      'Куриный лаваш ',
      'Бургер с лососем',
      'Бургер по аджарски ',
      'Бургер Классический ',
      'Бургер с курицей ',
    ];

    final allFoodImage = [
      '/uploads/product/1/original/1627019547.png',
      '/uploads/product/20/original/1623534042.png',
      '/uploads/product/21/original/1627139012.png',
      '/uploads/product/22/original/1627181391.png',
      '/uploads/product/30/original/1624292721.png',
    ];
    final prices = [
      '13000 ',
      '16000 ',
      '12000 ',
      '10000 ',
      '20000 ',
    ];

    return SizedBox(
      height: 400.0,
      child: ListView.builder(
        itemCount: allFoodTitle.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(AuthScreen()),
            child: Padding(
              padding: index == 0
                  ? const EdgeInsets.only(left: 24, right: 13)
                  : const EdgeInsets.only(right: 23),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                width: allFoodTitle.length == 1
                    ? screenSize.width * 0.88
                    : screenSize.width * 0.86,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, top: 20),
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
                                        allFoodImage[index],
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
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allFoodTitle[index],
                                style: FontStyles.semiBoldStyle(
                                  fontSize: 16,
                                  fontFamily: 'Ubuntu',
                                  color: const Color(0xff222E54),
                                ),
                              ),
                              Text(
                                prices[index] + 'sum'.tr,
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
                              'Куриный лаваш с сыром – идеальное и сытное блюдо, которое любят и взрослые, и дети. Тонкое тесто, свежие овощи, нежное куриное филе и тающий во рту сыр – этот вкус вы не забудете никогда.\r\n',
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/deliver.svg'),
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
                              SvgPicture.asset('assets/icons/clock.svg'),
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
      ),
    );
  }
}

class _UserWelcome extends StatelessWidget {
  const _UserWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'userWelcomeString1'.tr,
                            style: FontStyles.regularStyle(
                              fontSize: 22,
                              fontFamily: 'Montserrat',
                              color: const Color(0xff222E54),
                            ),
                            children: [
                              TextSpan(
                                text: ' ',
                                style: FontStyles.boldStyle(
                                  fontSize: 22,
                                  fontFamily: 'Montserrat',
                                  color: const Color(0xff222E54),
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'userWelcomeString2'.tr,
                        style: FontStyles.regularStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff222E54)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        'http://hamd.loko.uz/' + '/assets_files/img/user.png',
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  const CategoryButton({Key? key}) : super(key: key);

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  int selectedButton = 0;
  final allCategories = [
    'Первое',
    'Бургеры',
    'Второе',
    'Кофе',
    'Напитки',
    'Фреши',
    'Салаты',
    'Хлеб',
    'Рыба',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(
          height: 50,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allCategories.length,
              itemBuilder: (context, index) => Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 25)
                        : const EdgeInsets.only(left: 13),
                    child: RaisedButton(
                      elevation: 0,
                      color: selectedButton == index
                          ? ColorPalatte.strongRedColor
                          : Colors.white,
                      onPressed: () {
                        setState(() {
                          selectedButton = index;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        allCategories[index].toString(),
                        style: FontStyles.mediumStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: selectedButton == index
                              ? Colors.white
                              : const Color(0xff222E54),
                        ),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
