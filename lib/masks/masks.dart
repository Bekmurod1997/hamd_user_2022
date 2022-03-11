import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputMask {
  static MaskTextInputFormatter maskPhoneNumber = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter maskUzCard = MaskTextInputFormatter(
      mask: '8600 ####  ####  #### ', filter: {"#": RegExp(r'[0-9]')});
  static MaskTextInputFormatter maskHumo = MaskTextInputFormatter(
    mask: '9860 #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  static MaskTextInputFormatter maskDate =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
}
