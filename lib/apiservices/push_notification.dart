import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hamd_user/utils/my_prefs.dart';
import 'package:get/get.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp();
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    token = await FirebaseMessaging.instance.getToken();

    MyPref.fToken = token!;

    print('firebase toke: ${MyPref.fToken}');

    FirebaseMessaging.onBackgroundMessage(_onBackgoundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenandler);
  }

  static Future _onBackgoundHandler(RemoteMessage message) async {
    print('_onBackgoundHandler');
    // print("${message.data['title']}");
    // print("${message.data['driver_id']}");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('_onMessageHandler');
    // print("${message.messageId}");
    // print("${message.data['driver_id']}");
  }

  static Future _onMessageOpenandler(RemoteMessage message) async {
    print('_onMessageOpenandler');
    print("${message.messageId}");
  }
}
