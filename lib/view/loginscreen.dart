import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/controller/authcontroller.dart';

import '../utils/colors.dart';
import '../widgets/custom-button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController _authController = Get.put(AuthController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(text: TextSpan( text: 'Receipts reimagined - ', style: const TextStyle(fontSize: 18, color: Colors.black,),children: [TextSpan( text: 'Smartly',style: TextStyle(color: mainColor,                                ))
                          ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: mainColor),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: const Text(
                          'Manage all your receipts smartly and efficiently!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Center(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _authController.phoneNumber,
                            style: TextStyle(
                              color: mainColor,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your valid phone number',
                                hintStyle: TextStyle(
                                  color: mainColor,
                                )),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          'We’ll text you to confirm your number. Standard message and data rates apply.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Obx(
                        () => _authController.loading.value
                            ? const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : CustomButton(
                                onPress: () async {
                                  await _authController.sendOtp();
                                },
                                text: 'Get OTP',
                              ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
