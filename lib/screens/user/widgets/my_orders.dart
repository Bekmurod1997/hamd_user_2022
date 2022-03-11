import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/providers/my_orders_provider.dart';
import 'package:hamd_user/screens/user/widgets/order_stage.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrdersProvider>(
      builder: (context, myOrders, child) {
        return myOrders.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : myOrders.myOrders.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: myOrders.myOrders.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => OrderStage(
                                orderStage: myOrders.myOrders[index]));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 12, left: 15, bottom: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'order'.tr +
                                            myOrders.myOrders[index].id
                                                .toString(),
                                        style: FontStyles.regularStyle(
                                          fontSize: 18,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff222E54),
                                        ),
                                      ),
                                      SizedBox(height: 9),
                                      Text(
                                        myOrders.myOrders[index].productTotalSum
                                                .toString() +
                                            ' ' +
                                            'sum'.tr,
                                        style: FontStyles.boldStyle(
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            color: const Color(0xff222E54)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          myOrders.myOrders[index].date
                                              .toString(),
                                          textAlign: TextAlign.right,
                                          style: FontStyles.regularStyle(
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            color: const Color(0xff414141),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   children: [
                                      //     SvgPicture.asset(
                                      //       'assets/icons/vstar6.svg',
                                      //       width: 40,
                                      //     ),
                                      //     Text(
                                      //       '5.0',
                                      //       style: FontStyles.boldStyle(
                                      //           fontSize: 20,
                                      //           fontFamily: 'Poppins',
                                      //           color: const Color(0xff222E54)),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Text(
                    'youHaveNotOrdersYet'.tr,
                    textAlign: TextAlign.center,
                  );
      },
    );
  }
}
