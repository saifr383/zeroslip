import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/services/notifications.dart';
import 'package:untitled1/view/dashboard.dart';
import 'package:untitled1/view/loginscreen.dart';
import 'package:untitled1/view/receipt.dart';
import 'package:untitled1/view/splashscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'controller/authcontroller.dart';
import 'model/authModel.dart';

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
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
   log("FirebaseMessaging.onMessage.listenjddddddddddddddddddddddddddddddddddd");
   if (message != null) {
     final prefs = await SharedPreferences.getInstance();
     final String? token = prefs.getString('login')??'';
     if(token==null){
       Get.to(()=>LoginScreen());
     }
     else{
       final String? token = prefs.getString('login')??'';
       final String? refresh = prefs.getString('refresh')??'';
       final String? phone = prefs.getString('phoneno')??'';
       AuthController _controller=Get.put(AuthController());
       _controller.currentUser=AuthModel(access: token!, refresh: refresh!);

       _controller.phoneNumber.text=phone!;
       _controller..navcontroller.jumpToTab(2);
       Get.to(()=>DashBoard());
     }
   }


  },);
  FirebaseMessaging.instance.getInitialMessage().then(
        (message) async {
      if (message != null) {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('login')??'';
       if(token==null){
         Get.to(()=>LoginScreen());
       }
       else{
         final String? token = prefs.getString('login')??'';
         final String? refresh = prefs.getString('refresh')??'';
         final String? phone = prefs.getString('phoneno')??'';
         AuthController _controller=Get.put(AuthController());
         _controller.currentUser=AuthModel(access: token!, refresh: refresh!);

         _controller.phoneNumber.text=phone!;
         _controller..navcontroller.jumpToTab(2);
         Get.to(()=>DashBoard());
       }
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
