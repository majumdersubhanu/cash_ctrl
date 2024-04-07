import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRBPdfXMC4tHV0YcwgS7HVe7-AjV2tMoo',
    appId: '1:1059044138606:android:e7015c2c163a453a29507f',
    messagingSenderId: '1059044138606',
    projectId: 'cash-ctrl-official-7d879',
    storageBucket: 'cash-ctrl-official-7d879.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBGVoWDftoc4Fu9yNm6g9vqTFHHSa41Yw',
    appId: '1:1059044138606:ios:855ee92b7eeafee129507f',
    messagingSenderId: '1059044138606',
    projectId: 'cash-ctrl-official-7d879',
    storageBucket: 'cash-ctrl-official-7d879.appspot.com',
    iosBundleId: 'com.example.cashCtrl',
  );
}
