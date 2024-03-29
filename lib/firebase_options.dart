// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNgu4HAf14OY4fenD_yhkPqrMjQdVqB6E',
    appId: '1:163203932936:android:1a260a1e93d87b62da02bd',
    messagingSenderId: '163203932936',
    projectId: 'hamd-c7df5',
    storageBucket: 'hamd-c7df5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvw7DbW2D3WfG8L20M3lhFC8YkNGCKH60',
    appId: '1:163203932936:ios:49af30795f843c38da02bd',
    messagingSenderId: '163203932936',
    projectId: 'hamd-c7df5',
    storageBucket: 'hamd-c7df5.appspot.com',
    iosClientId:
        '163203932936-ucrqg73er9n4t69csmq0s0vk7pqf58de.apps.googleusercontent.com',
    iosBundleId: 'uz.hamdUser',
  );
}
