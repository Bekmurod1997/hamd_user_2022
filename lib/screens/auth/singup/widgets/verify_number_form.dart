import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'dart:async';

import 'package:hamd_user/utils/my_prefs.dart';

class VerifyNumberForm extends StatefulWidget {
  const VerifyNumberForm({Key? key}) : super(key: key);

  @override
  _VerifyNumberFormState createState() => _VerifyNumberFormState();
}

class _VerifyNumberFormState extends State<VerifyNumberForm> {
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  void validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (codeController.text == MyPref.code) {
        AllServices.codeConfirm(code: codeController.text);
        // ConfirmCode.codeConfirmFunction(code: codeController.text);
        // Get.offAll(HomeScreen());

        // Get.offAll(HomeScreen());
      } else {
        print('hatolik');
      }
    }
  }

  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(15)),
              height: 55.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.call,
                      color: Colors.grey,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: codeController,
                      // autofocus: true,
                      keyboardType: TextInputType.number,

                      //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15.0),
                        hintText: 'enterCode'.tr,
                        hintStyle: FontStyles.regularStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu',
                          color: const Color(0xff9E9E9E),
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            errorMessage = 'fieldCannotBeEmpty'.tr;
                          });
                          return '';
                        } else if (value.length < 6) {
                          setState(() {
                            errorMessage = 'fieldCannotBeLess6'.tr;
                          });
                          return '';
                        } else if (value != MyPref.code) {
                          setState(() {
                            errorMessage = 'pleaseEnterCorrectCode'.tr;
                          });
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorPalatte.strongRedColor,
                    ),
                  ),
                  errorMessage.isEmpty
                      ? Container()
                      : const SizedBox(
                          height: 10,
                        ),
                  Center(
                      child: _start == 0
                          ? GestureDetector(
                              onTap: () {
                                if (_start == 0) {
                                  setState(() {
                                    _start = 30;
                                  });
                                  startTimer();
                                  AllServices.signInUser(
                                      userNumber: MyPref.phoneNumber,
                                      fcmToken: MyPref.fToken);
                                  // SignIn.signInUser(
                                  //     userNumber: MyPref.phoneNumber,
                                  //     fcmToken: MyPref.fToken);
                                } else {
                                  // _showSnackBar(context);
                                  validateAndSave();
                                }
                              },
                              child: Text('sendCode'.tr))
                          : RichText(
                              text: TextSpan(
                                text: 'newCode'.tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                      text: '$_start',
                                      style: const TextStyle(
                                          color: ColorPalatte.strongRedColor)),
                                  const TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'sekund'.tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ))

                  // Text('newCode'.tr + '$_start' + 'sekund'.tr)),
                ],
              ),
              // child:
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .07),
            SizedBox(
              height: 54,
              width: screenSize.width * 0.8,
              child: RaisedButton(
                elevation: 0,
                color: ColorPalatte.strongRedColor,
                onPressed: () => validateAndSave(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'loginButton'.tr,
                  style: FontStyles.boldStyle(
                      fontSize: 16, fontFamily: 'Ubuntu', color: Colors.white),
                ),
              ),
            ),
          ],
        )));
  }
}
