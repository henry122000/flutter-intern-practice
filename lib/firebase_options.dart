// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCddRz1NKd5WEj6i196TIBbxCI1iXQLbe8',
    appId: '1:578974624415:web:cde659e97fc682662810aa',
    messagingSenderId: '578974624415',
    projectId: 'flutter-intern-practice',
    authDomain: 'flutter-intern-practice.firebaseapp.com',
    storageBucket: 'flutter-intern-practice.appspot.com',
    measurementId: 'G-FTZ49852CP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr_mJRER95gcz-DKlPA_1MkpATupBXZ2E',
    appId: '1:578974624415:android:359455ce1c85ef252810aa',
    messagingSenderId: '578974624415',
    projectId: 'flutter-intern-practice',
    storageBucket: 'flutter-intern-practice.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDutxThdoY3ui00e4xCz3weHSt3BnkDWgc',
    appId: '1:578974624415:ios:1bd5c40176cbe7982810aa',
    messagingSenderId: '578974624415',
    projectId: 'flutter-intern-practice',
    storageBucket: 'flutter-intern-practice.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDutxThdoY3ui00e4xCz3weHSt3BnkDWgc',
    appId: '1:578974624415:ios:1bd5c40176cbe7982810aa',
    messagingSenderId: '578974624415',
    projectId: 'flutter-intern-practice',
    storageBucket: 'flutter-intern-practice.appspot.com',
    iosBundleId: 'com.example.taskManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCddRz1NKd5WEj6i196TIBbxCI1iXQLbe8',
    appId: '1:578974624415:web:8fb3a8ec5e66238b2810aa',
    messagingSenderId: '578974624415',
    projectId: 'flutter-intern-practice',
    authDomain: 'flutter-intern-practice.firebaseapp.com',
    storageBucket: 'flutter-intern-practice.appspot.com',
    measurementId: 'G-2J7YMZZ9PT',
  );

}