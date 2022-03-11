import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/models/cart_list_model.dart';
import 'package:hamd_user/providers/adding_card_provider.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class OrderList extends StatefulWidget {
  final List<Data>? myOrders;
  OrderList({Key? key, required this.myOrders}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.myOrders?.length ?? 0,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return Stack(children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Image.network('http://hamd.loko.uz/' +
                            widget.myOrders![index].productPhoto!),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 35),
                            Text(widget.myOrders![index].productName!),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.myOrders![index].productPrice
                                      .toString(),
                                  style: FontStyles.semiBoldStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: const Color(0xff222E54),
                                  ),
                                ),
                                Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('pressing -');
                                      if (widget.myOrders![index].amount! > 1) {
                                        setState(() {
                                          widget.myOrders![index].amount =
                                              widget.myOrders![index].amount! -
                                                  1;
                                        });
                                        context
                                            .read<AddingCardProvider>()
                                            .addingToCard(
                                                productId: widget
                                                    .myOrders![index]
                                                    .productId!,
                                                productCount: widget
                                                    .myOrders![index].amount!,
                                                context: context);
                                      } else if (widget
                                              .myOrders![index].amount! ==
                                          1) {
                                        AllServices.deleteFromCart(
                                            context,
                                            widget.myOrders![index].productId
                                                .toString());
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/minus.svg',
                                      height: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    widget.myOrders![index].amount.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.myOrders![index].amount =
                                            widget.myOrders![index].amount! + 1;
                                      });
                                      context
                                          .read<AddingCardProvider>()
                                          .addingToCard(
                                              productId: widget
                                                  .myOrders![index].productId!,
                                              productCount: widget
                                                  .myOrders![index].amount!,
                                              context: context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/plus.svg',
                                      height: 27,
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    AllServices.deleteFromCart(
                        context, widget.myOrders![index].productId.toString());
                  },
                  child: const Icon(Icons.delete,
                      color: ColorPalatte.strongRedColor),
                ))
          ]);
        });
  }
}
