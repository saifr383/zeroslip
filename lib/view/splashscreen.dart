import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/controller/authcontroller.dart';
import 'package:untitled1/model/authModel.dart';
import 'package:untitled1/view/dashboard.dart';
import 'package:untitled1/view/loginscreen.dart';

import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  moveahead() async {

    final prefs = await SharedPreferences.getInstance();
   final String? token = prefs.getString('login')??'';
    final String? refresh = prefs.getString('refresh')??'';
   final String? phone = prefs.getString('phoneno')??'';
    await Future.delayed(Duration(seconds: 2));
   if(token=='') {
     Get.off(()=>LoginScreen());
   }
   else
  { AuthController _controller=Get.put(AuthController());
   _controller.currentUser=AuthModel(access: token!, refresh: refresh!);

   _controller.phoneNumber.text=phone!;
   Get.off(()=>DashBoard());
  }

  }
  @override
  void initState() {
    moveahead() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 20,),
            RichText(
                text: TextSpan(
                    text: 'Receipts reimagined - ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    children: [
                  TextSpan(
                      text: 'Smartly',
                      style: TextStyle(
                        color: mainColor,
                      ))
                ]))
          ],
        ),
      ),
    );
  }
}
