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
    apiKey: 'AIzaSyCKh2b8EuO6nAtIJeSZhMXPE5_ffgeNqIA',
    appId: '1:863184103268:web:4cd49ff3cb93082fe1bc71',
    messagingSenderId: '863184103268',
    projectId: 'app-movies-cb6fa',
    authDomain: 'app-movies-cb6fa.firebaseapp.com',
    storageBucket: 'app-movies-cb6fa.appspot.com',
    measurementId: 'G-7ZRGKZZB2E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAkiW6mHRXF_26hJBIt4-6iW3x70F-d_A',
    appId: '1:863184103268:android:a7d7a7aca31ea607e1bc71',
    messagingSenderId: '863184103268',
    projectId: 'app-movies-cb6fa',
    storageBucket: 'app-movies-cb6fa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBs8j4MIEKa1giDXfco09SqgzZc-TuFSCw',
    appId: '1:863184103268:ios:c38c53fbbc11c370e1bc71',
    messagingSenderId: '863184103268',
    projectId: 'app-movies-cb6fa',
    storageBucket: 'app-movies-cb6fa.appspot.com',
    iosBundleId: 'com.example.appMovies',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBs8j4MIEKa1giDXfco09SqgzZc-TuFSCw',
    appId: '1:863184103268:ios:c38c53fbbc11c370e1bc71',
    messagingSenderId: '863184103268',
    projectId: 'app-movies-cb6fa',
    storageBucket: 'app-movies-cb6fa.appspot.com',
    iosBundleId: 'com.example.appMovies',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKh2b8EuO6nAtIJeSZhMXPE5_ffgeNqIA',
    appId: '1:863184103268:web:e02c1021d8eac2bae1bc71',
    messagingSenderId: '863184103268',
    projectId: 'app-movies-cb6fa',
    authDomain: 'app-movies-cb6fa.firebaseapp.com',
    storageBucket: 'app-movies-cb6fa.appspot.com',
    measurementId: 'G-R07HEXNBJH',
  );

}