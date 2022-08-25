import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/services/notifications.dart';
import 'package:untitled1/view/loginscreen.dart';
import 'package:untitled1/view/receipt.dart';
import 'package:untitled1/view/splashscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? token=await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  LocalNotificationService.initialize();

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  void initState() {
  FirebaseMessaging.onMessage.listen(
        (message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        LocalNotificationService.createanddisplaynotification(message);

      }
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
   log("FirebaseMessaging.onMessage.listenjddddddddddddddddddddddddddddddddddd");

  },);
  FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Bai Jamjuree'
      ),
      home: SplashScreen(),
    );
  }
}
