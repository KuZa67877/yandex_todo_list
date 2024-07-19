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
    apiKey: 'AIzaSyBxPY-wX5cG4BVI8pdIdv4hRDmiIamlD2A',
    appId: '1:190560460552:web:132d89b0ca9a61a6cc16bd',
    messagingSenderId: '190560460552',
    projectId: 'yandex-todo-list',
    authDomain: 'yandex-todo-list.firebaseapp.com',
    storageBucket: 'yandex-todo-list.appspot.com',
    measurementId: 'G-08PR3SQ0ZD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUQqw6X59FqofNOqdE5f0u8AQpMhIqPA0',
    appId: '1:190560460552:android:78c4a5d8e31b7bbacc16bd',
    messagingSenderId: '190560460552',
    projectId: 'yandex-todo-list',
    storageBucket: 'yandex-todo-list.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrDxO4xVICjRMa7MPYGXQKzCHFjPwl0zQ',
    appId: '1:190560460552:ios:782a162b89290ad5cc16bd',
    messagingSenderId: '190560460552',
    projectId: 'yandex-todo-list',
    storageBucket: 'yandex-todo-list.appspot.com',
    iosBundleId: 'com.example.forBuild',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrDxO4xVICjRMa7MPYGXQKzCHFjPwl0zQ',
    appId: '1:190560460552:ios:782a162b89290ad5cc16bd',
    messagingSenderId: '190560460552',
    projectId: 'yandex-todo-list',
    storageBucket: 'yandex-todo-list.appspot.com',
    iosBundleId: 'com.example.forBuild',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxPY-wX5cG4BVI8pdIdv4hRDmiIamlD2A',
    appId: '1:190560460552:web:c3aa25776c273ef2cc16bd',
    messagingSenderId: '190560460552',
    projectId: 'yandex-todo-list',
    authDomain: 'yandex-todo-list.firebaseapp.com',
    storageBucket: 'yandex-todo-list.appspot.com',
    measurementId: 'G-ZE2SLZH046',
  );
}