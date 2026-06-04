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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgmbNUVxjXcHyqUxub6sdq2eocFbuCu-E',
    appId: '1:449327116621:android:0ab7045c3efe28e7044704',
    messagingSenderId: '449327116621',
    projectId: 'crypto-assistant-321a0',
    storageBucket: 'crypto-assistant-321a0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCftZSEzQzwcYnmNlIH6WYG1My1DZXZDGI',
    appId: '1:449327116621:ios:53341bf188803634044704',
    messagingSenderId: '449327116621',
    projectId: 'crypto-assistant-321a0',
    storageBucket: 'crypto-assistant-321a0.firebasestorage.app',
    iosBundleId: 'com.example.cryptoAssistant',
  );
}
