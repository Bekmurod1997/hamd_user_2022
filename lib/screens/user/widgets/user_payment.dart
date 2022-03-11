import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:get/get.dart';
import 'package:hamd_user/masks/masks.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/user/widgets/plastic_card.dart';
import 'package:provider/provider.dart';

class UserPayment extends StatefulWidget {
  const UserPayment({Key? key}) : super(key: key);

  @override
  State<UserPayment> createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController dateHumoController = TextEditingController();
  TextEditingController phoneUzController = TextEditingController();
  TextEditingController phoneHumoController = TextEditingController();
  TextEditingController humoController = TextEditingController();
  TextEditingController uzCardController = TextEditingController();

  TextEditingController humoCardController = TextEditingController();
  // TextEditingController uzCardController = TextEditingController();
  // TextEditingController dateHumoController = TextEditingController();
  TextEditingController dateUzCardController = TextEditingController();
  // TextEditingController phoneHumoController = TextEditingController();
  TextEditingController phoneUzCardController = TextEditingController();

  int selectedRadio = 0;
  int selectedCard = 0;
  bool loading = false;
  final uzCard = 1;
  final humoCard = 2;

  selectedRadioValue(int val) {
    selectedRadio = val;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer2<PlasticCardProvider, UserInfoProvider>(
          builder: (context, plastic, userInfo, child) {
            return plastic.isLoading || userInfo.isLoading
                ? const Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Row(
                    children: [
                      plastic.myPlastic.isEmpty
                          ? Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ColorPalatte.strongRedColor,
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (context, StateSetter state) {
                                            return Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 20, right: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'addNewCard'.tr,
                                                    style:
                                                        FontStyles.mediumStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Montserrat',
                                                      color: const Color(
                                                          0xff0E0E0E),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        child: SvgPicture.asset(
                                                          'assets/icons/uzcard.svg',
                                                          width: 40,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: RadioListTile(
                                                          activeColor:
                                                              Color(0xffFFBC41),
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .trailing,
                                                          value: 1,
                                                          groupValue:
                                                              selectedRadio,
                                                          onChanged:
                                                              (val) async {
                                                            print('Radio $val');
                                                            setState(() {
                                                              selectedRadio =
                                                                  val as int;
                                                            });
                                                            buildCardChange();

                                                            // print(
                                                            //     'changing zapros to plastic card');
                                                            // await PlasticCardType
                                                            //     .fetchPlasticCardType(14);

                                                            // if (plasticCardTypeController
                                                            //     .plasticCardTypeList
                                                            //     .isNotEmpty) {
                                                            //   setState(() {
                                                            //     uzCardController.text =
                                                            //         plasticCardTypeController
                                                            //             .plasticCardTypeList
                                                            //             .first
                                                            //             .cardNumber;
                                                            //     dateController.text =
                                                            //         plasticCardTypeController
                                                            //             .plasticCardTypeList
                                                            //             .first
                                                            //             .cardExpire;
                                                            //     phoneUzController.text =
                                                            //         plasticCardTypeController
                                                            //             .plasticCardTypeList
                                                            //             .first
                                                            //             .cardPhoneNumber;
                                                            //   });
                                                            // }
                                                            // if (selectedCard == 2) {
                                                            //   setState(() {
                                                            //     selectedCard = 1;
                                                            //   });
                                                            //   print(
                                                            //       'your selecte Card: ${selectedCard}');
                                                            // }
                                                            // state(() {
                                                            //   print(
                                                            //       'your selected radio is: ${selectedRadio}');
                                                            //   // selectedRadioValue(val);
                                                            // });
                                                            // Get.back();
                                                          },
                                                          title: Text(
                                                            'UzCard',
                                                            style: FontStyles
                                                                .mediumStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xff0E0E0E),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: Image.asset(
                                                          'assets/images/humo.png',
                                                          width: 40,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: RadioListTile(
                                                          activeColor:
                                                              const Color(
                                                                  0xffFFBC41),
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .trailing,
                                                          value: 2,
                                                          groupValue:
                                                              selectedRadio,
                                                          onChanged:
                                                              (val) async {
                                                            print(val);
                                                            print('Radio $val');
                                                            setState(() {
                                                              selectedRadio =
                                                                  val as int;
                                                            });
                                                            buildCardChange();
                                                            // print(
                                                            //     'changing zapros to plastic card');
                                                            // await PlasticCardType
                                                            //     .fetchPlasticCardType(15);

                                                            // if (plasticCardHumoController
                                                            //     .plasticCardTypeList
                                                            //     .isNotEmpty) {
                                                            //   setState(() {
                                                            // humoController.text =
                                                            //     plasticCardHumoController
                                                            //         .plasticCardTypeList
                                                            //         .first
                                                            //         .cardNumber;
                                                            // dateHumoController.text =
                                                            //     plasticCardHumoController
                                                            //         .plasticCardTypeList
                                                            //         .first
                                                            //         .cardExpire;
                                                            // phoneHumoController.text =
                                                            //     plasticCardHumoController
                                                            //         .plasticCardTypeList
                                                            //         .first
                                                            //         .cardPhoneNumber;
                                                            // });
                                                            // }
                                                            // if (selectedCard == 1) {
                                                            //   setState(() {
                                                            //     selectedCard = 2;
                                                            //   });
                                                            //   print(
                                                            //       'your selecte Card: ${selectedCard}');
                                                            // }
                                                            // state(() {
                                                            //   print(
                                                            //       'your selected radio is: ${selectedRadio}');
                                                            //   // selectedRadioValue(val);
                                                            // });
                                                            // print('Radio $val');
                                                            // selectedRadioValue(val);
                                                            // Get.back();
                                                          },
                                                          title: Text(
                                                            'Humo',
                                                            style: FontStyles
                                                                .mediumStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              color: Color(
                                                                  0xff0E0E0E),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : PlasticCard(
                              isDeleteIcon: true,
                              plasticId: plastic.myPlastic.first.id.toString(),
                              cardType:
                                  plastic.myPlastic.first.paymentType!.name!,
                              cardNumber: plastic.myPlastic.first.cardNumber,
                              dateExpire: plastic.myPlastic.first.cardExpire,
                              phoneNumber:
                                  plastic.myPlastic.first.cardPhoneNumber,
                              name: userInfo.userData?.name ?? '',
                            ),
                      // selectedCard == 1
                      //     ? Image.asset(
                      //         'assets/images/card-uzcard.png',
                      //         width: 254,
                      //       )
                      //     : selectedCard == 2
                      //         ? Image.asset(
                      //             'assets/images/humoCard.png',
                      //             width: 254,
                      //           )
                      //         : Text(''),
                    ],
                  );
          },
        )
      ],
    );
  }

  buildCardChange() {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, state) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(builder: (context, StateSetter state) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'addCard'.tr,
                          style: FontStyles.regularStyle(
                            fontSize: 17,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff232323),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 17),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'cardNumber'.tr,
                                    style: FontStyles.regularStyle(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xff646974),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0xffE1E1E1),
                                        )),
                                    child: TextFormField(
                                      controller: selectedRadio == uzCard
                                          ? uzCardController
                                          : humoCardController,
                                      onChanged: (text) {
                                        print(text);
                                      },
                                      inputFormatters: [
                                        selectedRadio == uzCard
                                            ? InputMask.maskUzCard
                                            : InputMask.maskHumo
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 8.0, bottom: 2, top: 2),
                                        hintText: selectedRadio == uzCard
                                            ? '8600'
                                            : '9860',
                                        hintStyle: FontStyles.regularStyle(
                                            fontSize: 16,
                                            fontFamily: 'Ubuntu',
                                            color: const Color(0xff9E9E9E)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'fieldCannotBeEmpty'.tr;
                                        } else if (value.length < 19) {
                                          return 'fieldCannotBeLess16'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'yearMonth'.tr,
                                              style: FontStyles.regularStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff646974),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xffE1E1E1),
                                                  )),
                                              child: TextFormField(
                                                controller:
                                                    selectedRadio == uzCard
                                                        ? dateUzCardController
                                                        : dateHumoController,
                                                onChanged: (text) {
                                                  print(text);
                                                },
                                                inputFormatters: [
                                                  InputMask.maskDate
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 2,
                                                          top: 2),
                                                  hintText: '08/24',
                                                  hintStyle:
                                                      FontStyles.regularStyle(
                                                          fontSize: 16,
                                                          fontFamily: 'Ubuntu',
                                                          color: const Color(
                                                              0xff9E9E9E)),
                                                  border: InputBorder.none,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'fieldCannotBeEmpty'
                                                        .tr;
                                                  } else if (value.length < 5) {
                                                    return 'fieldCannotBeLess4'
                                                        .tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'telNumber'.tr,
                                              style: FontStyles.regularStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff646974),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    width: 1,
                                                    color:
                                                        const Color(0xffE1E1E1),
                                                  )),
                                              child: TextFormField(
                                                controller:
                                                    selectedRadio == uzCard
                                                        ? phoneUzCardController
                                                        : phoneHumoController,
                                                onChanged: (text) {
                                                  print(text);
                                                },
                                                inputFormatters: [
                                                  InputMask.maskPhoneNumber
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 2,
                                                          top: 2),
                                                  hintText: '+998',
                                                  border: InputBorder.none,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'fieldCannotBeEmpty'
                                                        .tr
                                                        .tr;
                                                  } else if (value.length <
                                                      17) {
                                                    return 'fieldCannotBeLess'
                                                        .tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 54,
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 0,
                            color: ColorPalatte.strongRedColor,
                            onPressed: () async {
                              print('pressing add');
                              print(uzCardController.text);
                              print(humoCardController.text);
                              print(phoneUzCardController.text);
                              print(phoneHumoController.text);
                              print(dateUzCardController.text);
                              print(dateHumoController.text);
                              if (_formKey.currentState!.validate()) {
                                AllServices.addPlasticCard(
                                    context: context,
                                    typeId: selectedRadio == uzCard ? 14 : 15,
                                    cardNumber: selectedRadio == uzCard
                                        ? uzCardController.text
                                        : humoCardController.text,
                                    cardPhoneNumber: selectedRadio == uzCard
                                        ? phoneUzCardController.text
                                            .replaceAll(' ', '')
                                            .replaceAll('+', '')
                                        : phoneHumoController.text
                                            .replaceAll(' ', '')
                                            .replaceAll('+', ''),
                                    cardExpire: selectedRadio == uzCard
                                        ? dateUzCardController.text
                                        : dateHumoController.text);
                              }
                              // if (_formKey.currentState.validate()) {
                              //   await AddPlasticCardType.addPlasticCardType(
                              //     typeId: selectedRadio == uzCard ? 14 : 15,
                              //     cardNumber: selectedRadio == uzCard
                              //         ? uzCardController.text
                              //         : humoCardController.text,
                              //     cardPhoneNumber: selectedRadio == uzCard
                              //         ? phoneUzCardController.text
                              //         : phoneHumoController.text,
                              //     cardExpire: selectedRadio == uzCard
                              //         ? dateUzCardController.text
                              //         : dateHumoController.text,
                              //   );
                              //   await plasticCardUzcardController
                              //       .fetchPlasticCardType(14);
                              //   await plasticCardHumoController
                              //       .fetchPlasticCardHumo(15);
                              // } else {
                              //   print('no');
                              // }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'add'.tr,
                              style: FontStyles.boldStyle(
                                  fontSize: 16,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
