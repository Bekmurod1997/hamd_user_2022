abstract class ApiUrl {
  static const http = 'http://';
  static const baseUrl = 'hamd.loko.uz';
  static const apiUrl = '${http + baseUrl}/api/';

  // Authenticate

  static const user = '${apiUrl}user/';

  static const productType = '${apiUrl}category?type=product';

  static const signIn = '${user}sign-in';
  static const sendSmsCode = '${user}send-sms-code';
  static const logOut = '${user}log-out';

  //Driver

  static const profile = '${user}profile';
  static const updateProfile = '${user}update';

  static const allProducts = '${apiUrl}product';
  static const productDetails = '${apiUrl}product/view?id=';

  static const rateDriver = '${apiUrl}user/set-rating';
}
