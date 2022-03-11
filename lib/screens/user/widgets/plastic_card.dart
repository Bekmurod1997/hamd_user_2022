import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';

class PlasticCard extends StatelessWidget {
  final String? cardNumber;
  final String? name;
  final String? dateExpire;
  final String? phoneNumber;
  final String? cardType;
  final String? plasticId;
  final bool isDeleteIcon;
  const PlasticCard({
    Key? key,
    this.cardNumber,
    this.phoneNumber,
    this.plasticId,
    this.dateExpire,
    this.cardType,
    this.isDeleteIcon = false,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: MediaQuery.of(context).size.width * .88,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 11, bottom: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cardType == 'UzCard'
                        ? SvgPicture.asset(
                            'assets/icons/uzcard.svg',
                            height: 30,
                          )
                        : Image.asset(
                            'assets/images/humo.png',
                            height: 30,
                          ),
                    isDeleteIcon
                        ? IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: ColorPalatte.strongRedColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'areSureDeleteCard'.tr,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          'no'.tr.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: ColorPalatte.strongRedColor,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'yes'.tr.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: ColorPalatte.strongRedColor,
                                          ),
                                        ),
                                        onPressed: () async {
                                          AllServices.deletePlasticCard(
                                              context, plasticId!);
                                          // Get.back();
                                          // await DeletePlasticCard.deletePlasticCard(
                                          //     cardId: widget.plasticId,
                                          //     isUzCard: widget.isUzCard);
                                          // widget.isUzCard
                                          //     ? widget.uzCardController.clear()
                                          //     : widget.humoCardController.clear();
                                          // widget.isUzCard
                                          //     ? widget.dateUzCardController.clear()
                                          //     : widget.dateHumoController.clear();
                                          // widget.isUzCard
                                          //     ? widget.phoneUzCardController.clear()
                                          //     : widget.phoneHumoController.clear();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    cardNumber.toString().substring(0, 4),
                    style: FontStyles.boldStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  ),
                  Text(
                    cardNumber.toString().substring(4, 8),
                    style: FontStyles.boldStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  ),
                  Text(
                    cardNumber.toString().substring(8, 12),
                    style: FontStyles.boldStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  ),
                  Text(
                    cardNumber.toString().substring(12, 15),
                    style: FontStyles.boldStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'yearMonth'.tr,
                        style: FontStyles.regularStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff646974),
                        ),
                      ),
                      Text(
                        dateExpire.toString(),
                        style: FontStyles.boldStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff646974),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'telNumber'.tr,
                        style: FontStyles.regularStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff646974),
                        ),
                      ),
                      Text(
                        phoneNumber.toString(),
                        style: FontStyles.boldStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff646974),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    name.toString(),
                    style: FontStyles.regularStyle(
                      fontSize: 13,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
