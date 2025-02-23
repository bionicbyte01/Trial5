import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBQGoy8l8enaT_Q9kUKkXcy_SJjuD5DcLg",
            authDomain: "trial5-2u25hy.firebaseapp.com",
            projectId: "trial5-2u25hy",
            storageBucket: "trial5-2u25hy.firebasestorage.app",
            messagingSenderId: "159595699177",
            appId: "1:159595699177:web:d22814097351c7737e4978"));
  } else {
    await Firebase.initializeApp();
  }
}
