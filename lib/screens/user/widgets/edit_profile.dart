import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as g;
import 'package:hamd_user/constants/api.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/constants/fonts.dart';
import 'package:hamd_user/masks/masks.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/category_provder.dart';
import 'package:hamd_user/providers/language_provider.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/components/header.dart';
import 'package:hamd_user/utils/my_prefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class EditProfielScreen extends StatefulWidget {
  const EditProfielScreen({Key? key}) : super(key: key);

  @override
  State<EditProfielScreen> createState() => _EditProfielScreenState();
}

class _EditProfielScreenState extends State<EditProfielScreen> {
  Dio dio = Dio();
  bool editPressed = false;
  File? _userImage;
  var _imageAvatar;
  final ImagePicker _picker = ImagePicker();

  void selectAvatar(BuildContext context) async {
    final XFile? imageAvatar =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageAvatar == null) return;
    setState(() {
      _imageAvatar = imageAvatar.path;
      _userImage = File(imageAvatar.path);
      print('photo link $_imageAvatar');
      print('file photo link $_userImage');
    });
    context
        .read<UserInfoProvider>()
        .imageAvatarChanger(context, imageAvatar.path);
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = context.read<UserInfoProvider>().userData?.name ?? '';
    phoneController.text = context.read<UserInfoProvider>().userData!.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserInfoProvider>(
        builder: (context, userInfo, child) {
          return userInfo.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        icon1Url: 'assets/icons/Icon-left.svg',
                        onpress1: () => g.Get.back(),
                        title: 'profileTitle'.tr,
                        icon2Url: 'assets/icons/logout.svg',
                        onpress2: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('exiting'.tr),
                                  actions: [
                                    FlatButton(
                                      onPressed: () => g.Get.back(),
                                      child: Text('no'.tr),
                                    ),
                                    FlatButton(
                                      child: Text('yes'.tr),
                                      onPressed: () {
                                        // MyPref.allTokenCLear();
                                        // print('toke after exiting');
                                        // print(MyPref.token);
                                        // print('second toke after exiting');
                                        // print(MyPref.secondToken);
                                        // print('phone number after existing');
                                        // print(MyPref.phoneNumber);
                                        // g.Get.offAll(LandingScreen());
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        height2: 18,
                        height1: 14,
                        width1: 14,
                        width2: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 33, bottom: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: [
                                        Container(
                                            height: 95,
                                            width: 95,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: _userImage == null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: NetworkImage(
                                                        'http://hamd.loko.uz/' +
                                                            userInfo.userData!
                                                                .photo!),
                                                    // SvgPicture.asset(
                                                    //     'assets/icons/avatar.svg'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage:
                                                        FileImage(_userImage!),
                                                  )),
                                        Positioned(
                                          right: 25,
                                          bottom: -10,
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Color(0xff575F6B),
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    selectAvatar(context);
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'name'.tr,
                                        style: FontStyles.regularStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ubuntu',
                                          color: Color(0xff232323),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 0.0),
                                          hintText: 'hintName'.tr,
                                          hintStyle: FontStyles.regularStyle(
                                            fontSize: 17,
                                            fontFamily: 'Montserrat',
                                            color: Color(0xffAAAEB7),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 35),
                            Text(
                              'yourNumber'.tr,
                              style: FontStyles.regularStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                color: Color(0xff232323),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 55.0,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.phone_android,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: phoneController,
                                      inputFormatters: [
                                        InputMask.maskPhoneNumber
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(left: 15.0),
                                        hintText: 'enterYourNumber'.tr,
                                        hintStyle: FontStyles.regularStyle(
                                          fontSize: 12,
                                          fontFamily: 'Ubuntu',
                                          color: Color(0xff575F6B),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        color: Color(0xff575F6B),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, top: 20, bottom: 45),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          content: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .75,
                                            decoration: BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            LanguageProvider>()
                                                        .changeLanguage(context,
                                                            'ru', 'RU');
                                                    // language.changeLanguage(
                                                    //     context, 'ru', 'RU');
                                                    MyPref.lang = 'ru';

                                                    g.Get.back();
                                                    context
                                                        .read<
                                                            CategoryProvider>()
                                                        .fetchAllCategories(
                                                            context,
                                                            isAllowed: false);
                                                    context
                                                        .read<
                                                            ProductsByCategoryProvider>()
                                                        .fetchProductsByCategory(
                                                            context
                                                                .read<
                                                                    CategoryProvider>()
                                                                .categoryId);
                                                    context
                                                        .read<
                                                            CartListProvider>()
                                                        .fetchProductsOnCard();
                                                  },
                                                  // onTap: () {
                                                  //   languageController.changeLanguage(
                                                  //       'ru', 'RU');
                                                  //   MyPref.lang = 'ru';
                                                  //   categoryData.fetchCategories();
                                                  //   allProductsController
                                                  //       .fetchAllProducts();
                                                  //   productByCategoryController
                                                  //       .fetchProductByCategory(28);
                                                  //   cartListController
                                                  //       .fetchAllCartList();
                                                  //   g.Get.back();
                                                  // },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/russia.svg'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('Русский язык',
                                                          style: FontStyles
                                                              .regularStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'Ubuntu')),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 30),
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            LanguageProvider>()
                                                        .changeLanguage(context,
                                                            'uz', 'UZ');
                                                    MyPref.lang = 'uz';
                                                    g.Get.back();
                                                    context
                                                        .read<
                                                            CategoryProvider>()
                                                        .fetchAllCategories(
                                                            context,
                                                            isAllowed: false);
                                                    context
                                                        .read<
                                                            ProductsByCategoryProvider>()
                                                        .fetchProductsByCategory(
                                                            context
                                                                .read<
                                                                    CategoryProvider>()
                                                                .categoryId);
                                                    context
                                                        .read<
                                                            CartListProvider>()
                                                        .fetchProductsOnCard();
                                                  },
                                                  // onTap: () {
                                                  //   languageController.changeLanguage(
                                                  //       'uz', 'UZ');
                                                  //   MyPref.lang = 'uz';
                                                  //   categoryData.fetchCategories();
                                                  //   allProductsController
                                                  //       .fetchAllProducts();
                                                  //   productByCategoryController
                                                  //       .fetchProductByCategory(28);
                                                  //   cartListController
                                                  //       .fetchAllCartList();
                                                  //   g.Get.back();
                                                  // },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/uzbekistan.svg'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('O\'zbek tili',
                                                          style: FontStyles
                                                              .regularStyle(
                                                                  fontSize: 20,
                                                                  fontFamily:
                                                                      'Ubuntu')),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'languageChoice'.tr,
                                      style: FontStyles.semiBoldStyle(
                                        fontSize: 16,
                                        fontFamily: 'Ubuntu',
                                        color: Color(0xff222E54),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    MyPref.lang == 'uz'
                                        ? SvgPicture.asset(
                                            'assets/icons/uzbekistan.svg')
                                        : SvgPicture.asset(
                                            'assets/icons/russia.svg'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 40),
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 0,
                                color: ColorPalatte.strongRedColor,
                                onPressed: () async {
                                  if (editPressed == false) {
                                    setState(() {
                                      editPressed = true;
                                    });
                                    FormData formData = FormData.fromMap({
                                      'name': nameController.text,
                                      'phone': phoneController.text,
                                    });

                                    if (_userImage != null) {
                                      String fileName =
                                          _userImage!.path.split('/').last;
                                      formData.files.addAll([
                                        MapEntry(
                                          "photo",
                                          await MultipartFile.fromFile(
                                            _userImage!.path,
                                            filename: fileName,
                                          ),
                                        ),
                                      ]);
                                    }

                                    final token = MyPref.secondToken;
                                    var response = await dio.post(
                                      ApiUrl.updateProfile,
                                      data: formData,
                                      options: Options(
                                        headers: {
                                          HttpHeaders.authorizationHeader:
                                              'Bearer $token'
                                        },
                                      ),
                                      // body: {
                                      //   'name': nameController.text,
                                      //   'phone': phoneController.text,
                                      // },
                                    );
                                    if (response.statusCode == 200) {
                                      print('okayy');
                                      g.Get.snackbar('', '',
                                          messageText: Text(
                                            'yourDateSaved'.tr,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xff007E33));
                                      userInfo.fetchUserInfo();
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  'saveChanges'.tr,
                                  style: FontStyles.boldStyle(
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
