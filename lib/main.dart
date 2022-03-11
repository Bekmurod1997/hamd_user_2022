import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hamd_user/apiservices/push_notification.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/firebase_options.dart';
import 'package:hamd_user/locales/strings.dart';
import 'package:hamd_user/providers/adding_card_provider.dart';
import 'package:hamd_user/providers/cart_list_provider.dart';
import 'package:hamd_user/providers/category_provder.dart';
import 'package:hamd_user/providers/delivery_price_provider.dart';
import 'package:hamd_user/providers/language_provider.dart';
import 'package:hamd_user/providers/my_orders_provider.dart';
import 'package:hamd_user/providers/order_process_provider.dart';
import 'package:hamd_user/providers/plastic_card_provider.dart';
import 'package:hamd_user/providers/product_by_category_provider.dart';
import 'package:hamd_user/providers/product_detail_provider.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:hamd_user/screens/home/home_screen.dart';
import 'package:hamd_user/screens/landing/landing_screen.dart';
import 'package:hamd_user/utils/my_prefs.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsByCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductDetailProvdier(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddingCardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyOrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DeliveryPriceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlasticCardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProcessProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorPalatte.strongRedColor,
            secondary: ColorPalatte.strongRedColor,
          ),
          // primarySwatch: ColorPalatte.strongRedColor,
          primarySwatch: Colors.amber,
          primaryColor: ColorPalatte.strongRedColor,
        ),
        home: Initializer(),
        translations: StringTranslations(),
        locale: Locale("uz", "UZ"),
        fallbackLocale: Locale("uz", "UZ"),
      ),
    );
  }
}

class Initializer extends StatefulWidget {
  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  @override
  void initState() {
    super.initState();
    var locale = MyPref.lang == "uz" ? Locale("uz", "UZ") : Locale("ru", "RU");
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return MyPref.secondToken == '' ? LandingScreen() : HomeScreen();
  }
}
