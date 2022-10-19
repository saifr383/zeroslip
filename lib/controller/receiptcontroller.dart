import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ReceiptController extends GetxController{
  var path=''.obs;
  String pathTemp='';
  createBarcode(String no) async {
    final dm = Barcode.code128(useCode128C: true);


    final svg = dm.toSvg(no, height: 120);
    final tempDir = await getTemporaryDirectory();
    String pathTemp='${tempDir.path}/image.svg';
    final file = await File(pathTemp).create();
    await file.writeAsString(svg);
  path.value=pathTemp;

  }
  double value = 1;

}