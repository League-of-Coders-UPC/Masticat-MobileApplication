
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
    apiKey: 'AIzaSyAlMthbFkGpi4P7x9WeskXfxeOVT-6MmCY',
    appId: '1:1086010112901:web:08630e290287f0a2ee62ec',
    messagingSenderId: '1086010112901',
    projectId: 'masticat-d00f0',
    authDomain: 'masticat-d00f0.firebaseapp.com',
    storageBucket: 'masticat-d00f0.firebasestorage.app',
    measurementId: 'G-RYH5L6418S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqWfpDJYeNNFn-YcYbx5m7_EglYsTTpnU',
    appId: '1:1086010112901:android:5cb1794cb1beed26ee62ec',
    messagingSenderId: '1086010112901',
    projectId: 'masticat-d00f0',
    storageBucket: 'masticat-d00f0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC08CxS--oLmSE6iWTtv7yhU7P7IifofCw',
    appId: '1:1086010112901:ios:24ded98f75f4e2dbee62ec',
    messagingSenderId: '1086010112901',
    projectId: 'masticat-d00f0',
    storageBucket: 'masticat-d00f0.firebasestorage.app',
    iosBundleId: 'com.example.masticat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC08CxS--oLmSE6iWTtv7yhU7P7IifofCw',
    appId: '1:1086010112901:ios:24ded98f75f4e2dbee62ec',
    messagingSenderId: '1086010112901',
    projectId: 'masticat-d00f0',
    storageBucket: 'masticat-d00f0.firebasestorage.app',
    iosBundleId: 'com.example.masticat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAlMthbFkGpi4P7x9WeskXfxeOVT-6MmCY',
    appId: '1:1086010112901:web:be6b22bfe64eccf4ee62ec',
    messagingSenderId: '1086010112901',
    projectId: 'masticat-d00f0',
    authDomain: 'masticat-d00f0.firebaseapp.com',
    storageBucket: 'masticat-d00f0.firebasestorage.app',
    measurementId: 'G-SZTK1H7BD5',
  );
}
