import 'package:flutter/material.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:get/get.dart';

class PaymentCard extends StatelessWidget {
  final int? totalFoodPrice;
  final int? deliveryPrice;
  final int? total;
  // final CartListController cartListController = Get.find<CartListController>();

  final int sendIndex;
  PaymentCard(
      {required this.sendIndex,
      this.totalFoodPrice,
      this.deliveryPrice,
      this.total});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        // height:
        //     sendIndex == 1 ? screenSize.height * 0.26 : screenSize.height * .25,
        // width: screenSize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 12, right: 15),
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'orderDetails'.tr,
                    style: FontStyles.mediumStyle(
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      color: Color(0xff0E0900),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'foodPrice'.tr,
                      style: FontStyles.regularStyle(
                        fontSize: 13,
                        fontFamily: 'Montserrat',
                        color: Color(0xff757475),
                      ),
                    ),
                    Text(
                      totalFoodPrice.toString(),
                      style: FontStyles.mediumStyle(
                        fontSize: 13,
                        fontFamily: 'Montserrat',
                        color: Color(0xff0E0900),
                      ),
                    ),
                  ],
                ),
                sendIndex == 1 ? Container() : SizedBox(height: 0),
                sendIndex == 2
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'deliveryPrice'.tr,
                            style: FontStyles.regularStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: Color(0xff757475),
                            ),
                          ),
                          Text(
                            deliveryPrice.toString(),
                            style: FontStyles.mediumStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: Color(0xff0E0900),
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 12),
                Divider(
                  color: Color(0xff757475),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'totalPrice'.tr,
                      style: FontStyles.mediumStyle(
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        color: Color(0xff0E0900),
                      ),
                    ),
                    sendIndex == 1
                        ? Text(
                            total.toString(),
                            style: FontStyles.mediumStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: Color(0xff0E0900),
                            ),
                          )
                        : Text(
                            totalFoodPrice.toString(),
                            style: FontStyles.mediumStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: Color(0xff0E0900),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            )),
      ),
    );
  }
}
