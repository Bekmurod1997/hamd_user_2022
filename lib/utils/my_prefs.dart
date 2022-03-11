import 'package:get_storage/get_storage.dart';
import 'package:hamd_user/utils/shred_preference_constants.dart';

class MyPref {
  static final prefs = GetStorage();

  static String get token => prefs.read(SPKeys.token) ?? '';
  static String get code => prefs.read(SPKeys.code) ?? '';
  static String get secondToken => prefs.read(SPKeys.secondToken) ?? '';
  static String get phoneNumber => prefs.read(SPKeys.phoneNumber) ?? '';
  static String get lang => prefs.read(SPKeys.lang) ?? '';
  static String get langIndex => prefs.read(SPKeys.langIndex) ?? '';
  static String get uzbLang => prefs.read(SPKeys.uzbLang) ?? '';
  static String get rusLang => prefs.read(SPKeys.rusLang) ?? '';
  static String get fToken => prefs.read(SPKeys.fToken) ?? '';
  static String get plasticCardId => prefs.read(SPKeys.plasticCardId) ?? '';

  static set token(String value) => prefs.write(SPKeys.token, value);
  static set plasticCardId(String value) =>
      prefs.write(SPKeys.plasticCardId, value);
  static set fToken(String fToken) => prefs.write(SPKeys.fToken, fToken);

  static set phoneNumber(String phoneNumber) =>
      prefs.write(SPKeys.phoneNumber, phoneNumber);
  static set code(String codeValue) => prefs.write(SPKeys.code, codeValue);
  static set secondToken(String secondTokenvalue) =>
      prefs.write(SPKeys.secondToken, secondTokenvalue);
  static set lang(String lang) => prefs.write(SPKeys.lang, lang);
  static set langIndex(String langIndex) =>
      prefs.write(SPKeys.langIndex, langIndex);
  static set uzbLang(String uzbLang) => prefs.write(SPKeys.uzbLang, uzbLang);
  static set rusLang(String rusLang) => prefs.write(SPKeys.rusLang, rusLang);

  static clearToken() => prefs.remove(SPKeys.token);
  static clearSecondToken() => prefs.remove(SPKeys.secondToken);
  static clearCode() => prefs.remove(SPKeys.code);
  static clearPhoneNumber() => prefs.remove(SPKeys.phoneNumber);
  static clearLang() => prefs.remove(SPKeys.lang);
  static clearLangIndex() => prefs.remove(SPKeys.langIndex);
  static clearUzbLang() => prefs.remove(SPKeys.uzbLang);
  static clearRusLang() => prefs.remove(SPKeys.rusLang);

  static allTokenCLear() {
    prefs.remove(SPKeys.token);
    prefs.remove(SPKeys.secondToken);
    prefs.remove(SPKeys.code);
    prefs.remove(SPKeys.phoneNumber);
    prefs.remove(SPKeys.lang);
    prefs.remove(SPKeys.langIndex);
    prefs.remove(SPKeys.fToken);

    prefs.remove(SPKeys.uzbLang);
    prefs.remove(SPKeys.rusLang);
    prefs.remove(SPKeys.plasticCardId);
  }
}
