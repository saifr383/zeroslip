import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/model/profilemodel.dart';
import 'package:untitled1/view/loginscreen.dart';

import '../controller/authcontroller.dart';
import '../services/services.dart';
import '../utils/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool set = true;
  ProfileModel? _myNetworkFuture = null;
  AuthController _authController = Get.find<AuthController>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  getdata() async {
    _myNetworkFuture = await Services.getRProfileInfo(
        token: _authController.currentUser!.access);
    fname.text =_myNetworkFuture!.firstName!;
    lname.text = _myNetworkFuture!.lastName!;
    email.text = _myNetworkFuture!.email!;

    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: (!_myNetworkFuture.isNull)
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Profile Setting',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                         DateTime.now().microsecondsSinceEpoch<DateTime(2022,12,24).microsecondsSinceEpoch ?InkWell(
                            onTap: () async {
                              // bool res=await Services.logout(refresh: _authController.currentUser!.refresh, token:_authController.currentUser!.access);
                              //
                              if (true) {
                                final prefs =
                                await SharedPreferences.getInstance();
                                await prefs.setString('login', '');
                                await prefs.setString('refresh', '');
                                await prefs.setString('phoneno', '');
                                await prefs.setString('delete', _authController.phoneNumber.text);
                                Get.delete<AuthController>();
                                Get.offAll(() => LoginScreen());
                              } else
                                Get.snackbar('Error',
                                    'Something went wrong Please try again');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ):SizedBox(),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: () async {
                              // bool res=await Services.logout(refresh: _authController.currentUser!.refresh, token:_authController.currentUser!.access);
                              //
                              if (true) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('login', '');
                                await prefs.setString('refresh', '');
                                await prefs.setString('phoneno', '');
                                Get.delete<AuthController>();
                                Get.offAll(() => LoginScreen());
                              } else
                                Get.snackbar('Error',
                                    'Something went wrong Please try again');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Personal information',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                          controller: fname,
                          decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              hintText: 'Enter First Name',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                              fillColor: mainColor.withOpacity(0.1),
                              focusColor: mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: lname,
                          decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              hintText: 'Enter Last Name',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                              fillColor: mainColor.withOpacity(0.1),
                              focusColor: mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: email,
                          decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              hintText: 'Enter Email',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                              fillColor: mainColor.withOpacity(0.1),
                              focusColor: mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: _authController.phoneNumber,
                          decoration: InputDecoration(
                              enabled: false,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              hintText: 'Enter Mobile No',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 18),
                              fillColor: mainColor.withOpacity(0.1),
                              focusColor: mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(color: mainColor, width: 1.0),
                              ))),
                      const SizedBox(
                        height: 50,
                      ),
                      Obx(
                        () => _authController.loading.value
                            ? Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: mainColor,
                                ))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      FocusManager.instance.primaryFocus!.unfocus();
                                      _authController.loading.value = true;
                                      ProfileModel newuser = _myNetworkFuture!;
                                      print(fname.text.isNotEmpty);

                                      newuser = ProfileModel(
                                          firstName: fname.text,
                                          lastName: lname.text,
                                          email: email.text);
                                      print(newuser.firstName);

                                      if (newuser == _myNetworkFuture) {
                                        Get.snackbar('Error',
                                            'Please Update some Profile data');
                                      } else {
                                        bool response =
                                            await Services.updateProfile(
                                                user: newuser,
                                                token: _authController
                                                    .currentUser!.access);
                                        if (response) {
                                          await getdata();
                                          Get.snackbar('Success',
                                              'Profile Updated Successfully');
                                        } else
                                          Get.snackbar('Error',
                                              'Something went wrong Please try again');
                                      }
                                      _authController.loading.value = false;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: buttonColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Save profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: 'Bai Jamjuree',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )),
                              ),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: Get.height,
                child: Center(
                    child: CircularProgressIndicator(
                  color: mainColor,
                ))),
      ),
    );
  }
}
