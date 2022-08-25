import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController{
  List<String> store = ["All"];
  var dropdownvalue="All";
  var screendropdown="All".obs;
  double min=0;
  double max=1;

  var values = RangeValues(0, 1).obs;

  var start=DateTime(2019,1,1).obs;
  var end=DateTime.now().obs;
}