import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/models/my_orders_model.dart';
import 'package:hamd_user/screens/components/header.dart';
import 'package:hamd_user/screens/home/home_screen.dart';
import 'package:hamd_user/screens/user/widgets/stages.dart';

class OrderStage extends StatefulWidget {
  final Data orderStage;

  const OrderStage({Key? key, required this.orderStage}) : super(key: key);

  @override
  State<OrderStage> createState() => _OrderStageState();
}

class _OrderStageState extends State<OrderStage> {
  final CarouselController _controller = CarouselController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: SafeArea(
        child: Column(
          children: [
            Header(
              icon1Url: 'assets/icons/Icon-left.svg',
              onpress1: () => Get.back(),
              title: 'orderStatus',
              icon2Url: 'assets/icons/empty.svg',
              onpress2: () => print('s'),
              height2: 18,
              height1: 14,
              width1: 14,
              width2: 18,
              hasAction: false,
              isSecondIconSee: false,
            ),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: 45,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ColorPalatte.strongRedColor,
                      ),
                      child: Center(
                        child: Text(
                          'D ' + widget.orderStage.id.toString(),
                          style: FontStyles.boldStyle(
                            fontSize: 18,
                            fontFamily: 'Product Sans',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 250,
                            height: 250,
                            child: CarouselSlider.builder(
                              itemCount:
                                  widget.orderStage.orderProducts!.length,
                              carouselController: _controller,
                              itemBuilder:
                                  (context, itemIndex, pageViewIndex) =>
                                      Image.network('http://hamd.loko.uz/' +
                                          widget
                                              .orderStage
                                              .orderProducts![itemIndex]
                                              .product!
                                              .photo!),
                              options: CarouselOptions(
                                  height: 200.0,
                                  enlargeCenterPage: true,
                                  autoPlay: false,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: false,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  viewportFraction: 0.8,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentPage = index;
                                    });
                                    print('currentPage');
                                    print(currentPage);
                                  }),
                            ),
                          ),
                        ),
                        if (widget.orderStage.orderProducts!.length > 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.orderStage.orderProducts!
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () {
                                  _controller.animateToPage(entry.key);
                                  print('entery jey');
                                  print(entry.key);
                                },
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : ColorPalatte.strongRedColor)
                                          .withOpacity(currentPage == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          ),
                        SizedBox(
                          height: 35,
                        ),
                        Stages(
                          bigTitle: 'orderAccepted'.tr,
                          iconUrl: 'assets/icons/clock-alt.svg',
                          smallTitle: widget.orderStage.date,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: 30.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) => Container(
                                height: 8,
                                width: 2,
                                color: Color(0xffFB6A43),
                                margin: EdgeInsets.only(
                                    bottom: 2, left: 20, top: 2),
                              ),
                            ),
                          ),
                        ),
                        Stages(
                          bigTitle: 'cooking'.tr,
                          iconUrl: 'assets/icons/flag.svg',
                          smallTitle: widget.orderStage.date,
                        ),
                        widget.orderStage.status == 2 ||
                                widget.orderStage.status == 3
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                width: 30.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    4,
                                    (index) => Container(
                                      height: 8,
                                      width: 2,
                                      color: Color(0xffFB6A43),
                                      margin: EdgeInsets.only(
                                          bottom: 2, left: 20, top: 2),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        widget.orderStage.status == 2 ||
                                widget.orderStage.status == 3
                            ? Stages(
                                bigTitle: 'givenToDriver'.tr,
                                iconUrl: 'assets/icons/deliver-alt.svg',
                                smallTitle: widget.orderStage.date.toString(),
                              )
                            : Container(),
                        SizedBox(height: 95),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width * 0.86,
                          height: 63,
                          child: RaisedButton(
                            elevation: 0,
                            color: Color(0xff9F111B),
                            onPressed: () => Get.to(HomeScreen()),
                            // onPressed: () => _showSnackBar(context),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              'goHomeScreen'.tr.toUpperCase(),
                              style: FontStyles.mediumStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 26)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
