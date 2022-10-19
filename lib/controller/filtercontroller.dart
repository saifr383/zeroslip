import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController{
  List<String> store = ["All"];
  List<String> category = ["All"];
  var dropdownvalue="All".obs;
  var categorydropdownvalue="All".obs;
  var screendropdown="All".obs;
  var screencategorydropdown="All".obs;
  double min=0;
  double max=1;

  var values = RangeValues(0, 1).obs;

  var start=DateTime(2019,1,1).obs;
  var end=DateTime.now().obs;
}