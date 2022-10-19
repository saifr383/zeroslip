import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/model/homemodel.dart';
import 'package:untitled1/model/profilemodel.dart';
import 'package:untitled1/model/receiptmodel.dart';
import 'package:untitled1/utils/constants.dart';

import '../model/storemode.dart';

class Services {
  static Future<bool> generateOtp({
    required String phoneNo,

  }) async {
    final hurl = Uri.parse(Constants.generateOtp);
    http.Response response = await http
        .post(hurl, headers: {
      "Content-Type": "application/json",

    },body: json.encode({
      "phone": phoneNo,

    }));
    if(response.statusCode==200)
    return true;
    else
      return false;
  }
  static Future<Map> confirmOtp({
    required String phoneNo,
    required String pin,

  }) async {

    final hurl = Uri.parse(Constants.confirmOtp);
    http.Response response = await http
        .post(hurl, headers: {
      "Content-Type": "application/json",
    },body: json.encode({
      "phone": phoneNo,
      "pin":pin

    }));
    print(response.body.toString());
    if(response.statusCode==200) {

      return jsonDecode(response.body);
    } else {
      Get.snackbar('Error','Something went wrong please try again',backgroundColor: Colors.white);
      return {};
    }

  }
  static Future<HomeModel> getHomeData({
    required String token,

  }) async {
print(token);
    final hurl = Uri.parse(Constants.getHomeData);
    print('hiiiiiiiiiiiiiiiii');
    http.Response response = await http.get(
      hurl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
print(response.body.toString());



      return HomeModel.fromJson(jsonDecode(response.body));


  }
  static Future<List<ReceiptModel>> getReceipt({
    required String token,

  }) async {
    print(token);
    final hurl = Uri.parse(Constants.getReceipt);
    print('hiiiiiiiiiiiiiiiii');
    http.Response response = await http.get(
      hurl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body.toString());
    List<ReceiptModel> list=[];
    print('=========================================outputin');
List data=jsonDecode(response.body);

    print('=========================================outputout');

data.forEach((element) {list.add(ReceiptModel.fromJson(element));});

    return list;


  }
  static Future<ProfileModel> getRProfileInfo({
    required String token,

  }) async {
    print(token);
    final hurl = Uri.parse(Constants.getProfileInfo);
    http.Response response = await http.get(
      hurl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body.toString());

    var data=ProfileModel.fromJson(jsonDecode(response.body));


    return data;


  }
  static Future<ReceiptModel?> getReceiptDetail({
    required String number,

  }) async {

    final hurl = Uri.parse("${Constants.getReceiptDetail}$number");

    http.Response response = await http.get(
      hurl,
    );
    print(response.body.toString());
    var data=ReceiptModel.fromJson(jsonDecode(response.body));

    return data;


  }
  static Future<bool> updateProfile({
    required ProfileModel user,
    required String token

  }) async {
    final hurl = Uri.parse(Constants.getProfileInfo);
    http.Response response = await http
        .post(hurl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",

    },body: json.encode(user.toJson()));
    if(response.statusCode==200)
      return true;
    else
      return false;
  }
  static Future<bool> updateFcmToken({
    required String fcm,
    required String token

  }) async {
    final hurl = Uri.parse(Constants.updateFcm);
    http.Response response = await http
        .post(hurl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",

    },body: json.encode({'token':fcm}));
    if(response.statusCode==200)
      return true;
    else
      return false;
  }
  static Future<bool> logout({
    required String refresh,
    required String token

  }) async {
    final hurl = Uri.parse(Constants.logout);
    http.Response response = await http
        .post(hurl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",

    },body: json.encode({'refresh_token':refresh}));
    if(response.statusCode==200)
      return true;
    else
      return false;
  }
  static Future<List<StoreModel>> getStores({
    required String token,

  }) async {
    print(token);
    final hurl = Uri.parse(Constants.stores);

    http.Response response = await http.get(
      hurl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    List<StoreModel> list=[];

    List data=jsonDecode(response.body);


    data.forEach((element) {list.add(StoreModel.fromJson(element));});


    return list;


  }
  static Future<List<StoreModel>> getCategory({
    required String token,

  }) async {
    print(token);
    final hurl = Uri.parse(Constants.category);

    http.Response response = await http.get(
      hurl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    List<StoreModel> list=[];

    List data=jsonDecode(response.body);


    data.forEach((element) {list.add(StoreModel.fromJson(element));});


    return list;


  }

}