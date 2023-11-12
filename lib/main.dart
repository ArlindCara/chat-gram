import 'dart:io';

import 'package:chat_gram/screens/splashScreen.dart';
import 'package:chat_gram/utils/pushNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const bool USE_EMULATOR = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (USE_EMULATOR) {
    await _connectToFirebaseEmulator();
  }

  await PushNotificationService().setupInteractedMessage();
  runApp(MyApp());
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
}

Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  // [Firestore | localhost:8080]
  FirebaseFirestore.instance.settings = const Settings(
    host: '10.0.2.2:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  // [Authentication | localhost:9099]
  await FirebaseAuth.instance.useAuthEmulator('$localHostString', 9099);

  // [Storage | localhost:9199]
  await FirebaseStorage.instance.useStorageEmulator(
    '$localHostString',
    9199,
  );

  FirebaseFunctions.instance.useFunctionsEmulator('$localHostString', 5001);

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade300,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}