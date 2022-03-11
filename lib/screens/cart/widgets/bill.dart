import 'package:flutter/material.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/models/cart_list_model.dart';
import 'package:get/get.dart';
import 'package:hamd_user/providers/delivery_price_provider.dart';
import 'package:provider/provider.dart';

class BillScreen extends StatefulWidget {
  final List<Data> orders;
  final int selectedIndex;
  const BillScreen(
      {Key? key, required this.selectedIndex, required this.orders})
      : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  int sum = 0;
  int? finalPrice;
  @override
  void initState() {
    for (var i = 0; i < widget.orders.length; i++) {
      setState(() {
        sum += widget.orders[i].totalPrice!;
      });
    }
    if (widget.selectedIndex == 1) {
      setState(() {
        finalPrice = sum + context.read<DeliveryPriceProvider>().price;
      });
    }
    super.initState();
  }

  int changer(int price) {
    return price + context.read<DeliveryPriceProvider>().price;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: screenSize.width * 0.86,
        height: widget.selectedIndex == 2 ? 110 : 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'foodPrice'.tr,
                  style: FontStyles.mediumStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: const Color(0xff494D6D),
                  ),
                ),
                Text(
                  sum.toString(),
                  style: FontStyles.mediumStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: const Color(0xff494D6D),
                  ),
                ),
              ],
            ),
            widget.selectedIndex == 2
                ? Container()
                : const SizedBox(
                    height: 13,
                  ),
            widget.selectedIndex == 2
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'deliveryPrice'.tr,
                        style: FontStyles.mediumStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff494D6D),
                        ),
                      ),
                      Consumer<DeliveryPriceProvider>(
                        builder: (context, price, child) {
                          return price.isLoading
                              ? const Text('0')
                              : Text(
                                  price.price.toString(),
                                  style: FontStyles.mediumStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    color: const Color(0xff494D6D),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalPrice'.tr,
                  style: FontStyles.semiBoldStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    color: const Color(0xff9F111B),
                  ),
                ),
                widget.selectedIndex == 2
                    ? Text(
                        sum.toString(),
                        style: FontStyles.semiBoldStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff9F111B),
                        ),
                      )
                    : Text(
                        changer(sum).toString(),
                        style: FontStyles.semiBoldStyle(
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff9F111B),
                        ),
                      )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
