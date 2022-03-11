import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/masks/masks.dart';
import 'package:hamd_user/utils/my_prefs.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String errorMessage = '';
  TextEditingController phoneNumberController =
      TextEditingController(text: '+998');
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // String fcmToken;
  // configureFCM() async {
  //   var token = await _firebaseMessaging.getToken();
  //   setState(() {
  //     fcmToken = token;
  //     print('fcmTokem: $fcmToken');
  //   });
  // }

//changes
  @override
  void initState() {
    super.initState();
    // configureFCM();
  }

  final _formKey = GlobalKey<FormState>();
  void validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');

      Get.dialog(
        Scaffold(
          backgroundColor: Colors.black.withOpacity(.1),
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              width: double.infinity,
              height: 100.0,
              child: Row(
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ColorPalatte.strongRedColor),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'pleaseWait'.tr,
                    style: FontStyles.lightStyle(
                      fontSize: 15,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      print(phoneNumberController.text);
      AllServices.signInUser(
          userNumber: phoneNumberController.text, fcmToken: '${MyPref.fToken}');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
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
                    inputFormatters: [InputMask.maskPhoneNumber],
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      // hintText: "+998",
                      contentPadding: EdgeInsets.only(left: 15.0),
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
                      } else if (value.length < 17) {
                        setState(() {
                          errorMessage = 'fieldCannotBeLess'.tr;
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
          errorMessage.isEmpty ? Container() : const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 12,
              color: ColorPalatte.strongRedColor,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 54,
            width: screenSize.width * 0.8,
            child: RaisedButton(
              elevation: 0,
              color: ColorPalatte.strongRedColor,
              onPressed: validateAndSave,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                'sendCode'.tr,
                style: FontStyles.boldStyle(
                    fontSize: 16, fontFamily: 'Ubuntu', color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
