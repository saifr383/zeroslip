import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:untitled1/controller/authcontroller.dart';


import '../utils/colors.dart';
import '../widgets/custom-button.dart';
import 'dashboard.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController _authController=Get.find<AuthController>();
  @override
  void initState() {

    _authController.otpCode=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){Get.back();},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: mainColor,
              size: 35,
            ),
          ),
        ),
      ),
      body: Column(

        children: [
          const SizedBox(height: 40,),
          Image.asset('assets/images/otpicon.png'),
          const SizedBox(height: 30,),
          Text(
            'Confirm your number',
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 28, color: mainColor),
          ),
          const SizedBox(height: 10,),
           Text(
            'Enter the code we sent over SMS to ${_authController.phoneNumber.text}',
            style: const TextStyle(
                 fontSize: 13, color: Colors.black),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PinCodeTextField(
              keyboardType: TextInputType.number,
              controller: _authController.otpCode,

              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                disabledColor: Colors.white,
                inactiveColor: Colors.black,
                activeColor: Colors.black,
                selectedFillColor: Colors.white,
                errorBorderColor: Colors.black,
                inactiveFillColor: Colors.white,
                 selectedColor: Colors.black,

                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.white,
                borderWidth: 1,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {

              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              }, appContext: context,
            ),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: () async {
              await _authController.resendOtp();
            },
            child: RichText(
              text: TextSpan(
                  text: 'Didn’t get a code? ',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black, ),
                  children: [
                    TextSpan(
                        text: 'Resend code',
                        style: TextStyle(
                          color: buttonColor,))
                  ]),
            ),
          ),
        const SizedBox(height: 40,),
        Obx(
            ()=>_authController.loading.value? Align(alignment:Alignment.center,child: CircularProgressIndicator(color:mainColor,)): CustomButton(onPress: () async {
           await _authController.verifyOtp();

          },text: 'Verify',),
        )
        ],
      ),
    );
  }
}
