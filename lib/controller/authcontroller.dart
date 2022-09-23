import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/model/authModel.dart';
import 'package:untitled1/services/services.dart';
import 'package:untitled1/utils/colors.dart';
import 'package:untitled1/view/otpscreen.dart';

import '../view/dashboard.dart';
import '../view/home.dart';

class AuthController extends GetxController
{
  PersistentTabController navcontroller = PersistentTabController(initialIndex: 0);
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController otpCode=TextEditingController();
  var loading=false.obs;
  AuthModel? currentUser;
  Future<void> sendOtp() async {
    if(!phoneNumber.text.isEmpty){
      loading.value=true;
      bool response=await Services.generateOtp(phoneNo: phoneNumber.text);
      if(response){
        loading.value=false;
        Get.to(()=>OtpScreen());
      }
      else {
        loading.value=false;
        Get.snackbar('Error', 'Something went wrong Please try again');
      }

    }
    else {
      Get.snackbar('Error','Please Enter Some Number');
    }
  }
  Future<void> resendOtp() async {
    loading.value=true;
      bool response=await Services.generateOtp(phoneNo: phoneNumber.text);
      if(response){
        Get.snackbar('Success', 'Otp resend Successfully');
      }
      else {
        Get.snackbar('Error', 'Something went wrong Please try again');
      }
    loading.value=false;


  }
  Future<void> verifyOtp() async {
    if(!otpCode.text.isEmpty){
      loading.value=true;
      Map response=await Services.confirmOtp(phoneNo: phoneNumber.text,pin: otpCode.text);
      print(response.toString());
     if(response.isEmpty){
        loading.value=false;
        Get.snackbar('Error', 'Enter a valid Otp',);
      }
      else {

       currentUser=AuthModel.fromJson(response as Map<String,dynamic>);
       String? token=await FirebaseMessaging.instance.getToken();
       bool responsedata=await Services.updateFcmToken(fcm: token!,token: currentUser!.access);
       final prefs = await SharedPreferences.getInstance();
       await prefs.setString('login', currentUser!.access);
       await prefs.setString('refresh', currentUser!.refresh);
       await prefs.setString('phoneno', phoneNumber.text);
        loading.value=false;

        Get.offAll(()=>DashBoard(),);


      }

    }
    else {
      Get.snackbar('Error','Please Enter Some Number');
    }
  }
}