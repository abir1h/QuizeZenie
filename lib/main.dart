import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'src/feature/app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyB5ULJik8yQ05iYcppZng7xQrlXEGGD3-E",
    appId: "1:517673954491:android:a8f1f77770a025f9de8d9e",
    messagingSenderId: "517673954491",
    projectId: "quiz-zenie",
    storageBucket: "quiz-zenie.firebasestorage.app",
  ));
  // await initLocalServices();
  // setup();
  HttpOverrides.global = MyHttpOverrides();

  ///Init notification
  // NotificationClient.instance.preInit();
  runApp(const Application());
}
