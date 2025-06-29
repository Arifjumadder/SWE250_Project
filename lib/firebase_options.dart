import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBEQw8MsK4Te_uxlmHN7CftEpbB4QKogtw",
    authDomain: "first-app-edc40.firebaseapp.com",
    projectId: "first-app-edc40",
    storageBucket: "first-app-edc40.firebasestorage.app",
    messagingSenderId: "820606337259",
    appId: "1:820606337259:web:e49d10610a173249d1beae",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBEQw8MsK4Te_uxlmHN7CftEpbB4QKogtw",
    projectId: "first-app-edc40",
    storageBucket: "first-app-edc40.firebasestorage.app",
    messagingSenderId: "820606337259",
    appId: "1:820606337259:web:e49d10610a173249d1beae",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBEQw8MsK4Te_uxlmHN7CftEpbB4QKogtw",
    projectId: "first-app-edc40",
    storageBucket: "first-app-edc40.firebasestorage.app",
    messagingSenderId: "820606337259",
    appId: "1:820606337259:web:e49d10610a173249d1beae",
    iosBundleId: "your-ios-bundle-id",
  );
}
