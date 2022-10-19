import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/controller/receiptcontroller.dart';
import 'package:untitled1/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/receiptmodel.dart';
import '../services/services.dart';
import '../utils/colors.dart';

class ReceiptDetail extends StatefulWidget {
  String number;
  ReceiptDetail({Key? key, required this.number}) : super(key: key);

  @override
  State<ReceiptDetail> createState() => _ReceiptDetailState();
}

class _ReceiptDetailState extends State<ReceiptDetail> {
  ReceiptController _controller=Get.put(ReceiptController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder(
          future: Services.getReceiptDetail(number: widget.number),
          builder: (context, AsyncSnapshot<ReceiptModel?> snapshot) {
            if (snapshot.hasData) {
           _controller.createBarcode(snapshot.data!.posReceiptNumber.toString());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 30,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CachedNetworkImage(
                            imageUrl:
                                '${Constants.baseUrl}${snapshot.data!.merchant!.logoUrl!.substring(6)}',
                            height: 120,
                            width: 150,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/defaultbrandlogo.png',
                              height: 60,
                              width: 80,
                              fit: BoxFit.fill,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                                'assets/images/defaultbrandlogo.png'),
                          ),
                          Text(
                            snapshot.data!.merchant!.name!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Receipt Tax Invoice',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${snapshot.data!.createdAt!.day}/${snapshot.data!.createdAt!.month}/${snapshot.data!.createdAt!.year} at ${snapshot.data!.createdAt!.hour}:${snapshot.data!.createdAt!.minute}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.items!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                  left: 15, top: 8, bottom: 8, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.items![index].name!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Price:${snapshot.data!.items![index].price.toString()}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Quantity:${snapshot.data!.items![index].quantity.toString()}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.items![index].total.toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'GST included in total',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.salesTax.toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'VAT included in total',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.vatTax.toString()}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Row(
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.total.toString()}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Row(
                              children: [
                                const Text(
                                  'Discount',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.discount.toString()}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Row(
                              children: [
                                const Text(
                                  'Grand Total',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  '${snapshot.data!.merchant!.country!.currency!.denotion!.substring(0, 2)} ${snapshot.data!.grandTotal.toString()}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          const Text(
                            'Receipt#',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.receiptNumber.toString(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(()=> SvgPicture.file(File(_controller.path.value,),width: Get.width*0.7,)),


                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.merchant!.name!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Address of the branch',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          // const Text(
                          //   'Open 9:30am - 11:00pm',
                          //   style: TextStyle(
                          //     color: Colors.green,
                          //     fontSize: 18,
                          //   ),
                          // ),
                          Text(
                            'NTN # ${snapshot.data!.merchant!.ntnNumber}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          snapshot.data!.merchant!.facebookUrl != null &&
                                  snapshot.data!.merchant!.twitterUrl != null &&
                                  snapshot.data!.merchant!.instagramUrl !=
                                      null &&
                                  snapshot.data!.merchant!.websiteUrl != null
                              ? const Text(
                                  'Socialise with us',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              : SizedBox(),
                          snapshot.data!.merchant!.facebookUrl != null &&
                              snapshot.data!.merchant!.twitterUrl != null &&
                              snapshot.data!.merchant!.instagramUrl !=
                                  null &&
                              snapshot.data!.merchant!.websiteUrl != null
                              ? const SizedBox(
                            height: 10,
                          ):SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              snapshot.data!.merchant!.facebookUrl != null
                                  ? InkWell(
                                      onTap: () async {
                                        Uri uri=Uri.parse(snapshot.data!.merchant!.facebookUrl);
                                        await launchUrl(uri);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/fbicon.svg',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  : SizedBox(),
                              const SizedBox(
                                width: 12,
                              ),
                              snapshot.data!.merchant!.instagramUrl != null
                                  ? InkWell(
                                      onTap: () async {
                                        Uri uri=Uri.parse(snapshot.data!.merchant!.instagramUrl);
                                        await launchUrl(uri);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/instaicon.svg',
                                          width: 30,
                                          height: 30),
                                    )
                                  : SizedBox(),
                              const SizedBox(
                                width: 12,
                              ),
                              snapshot.data!.merchant!.websiteUrl != null
                                  ? InkWell(
                                      onTap: () async {
                                        Uri uri=Uri.parse(snapshot.data!.merchant!.websiteUrl);
                                        await launchUrl(uri);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/linkedinicon.svg',
                                          width: 30,
                                          height: 30),
                                    )
                                  : SizedBox(),
                              const SizedBox(
                                width: 12,
                              ),
                              snapshot.data!.merchant!.twitterUrl != null
                                  ? InkWell(
                                      onTap: () async {
                                        Uri uri=Uri.parse(snapshot.data!.merchant!.twitterUrl);
                                        await launchUrl(uri);
                                      },
                                      child: SvgPicture.asset(
                                          'assets/images/twittericon.svg',
                                          width: 30,
                                          height: 30))
                                  : SizedBox(),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Image.asset(
                    //   'assets/images/samplead.png',
                    //   width: Get.width,
                    // ),

                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'POWERED BY ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              Image.asset(
                                'assets/images/logo.png',
                                height: 50,
                                width: 80,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'This receipt is generated by ZeroSlip, a trusted third-party provider.\nPlease contact the merchant directly for any receipt queries.',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Receipt id:${snapshot.data!.receiptNumber}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Privacy Policy | Unsubscribe from promotions',
                            style: TextStyle(color: mainColor, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '© 2022 ZeroSlip Pvt Ltd',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'How was our Service',
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    // SizedBox(height: 5,),
                    // Center(
                    //   child: RatingStars(
                    //     value: value,
                    //     onValueChanged: (v) {
                    //       //
                    //       setState(() {
                    //         value = v;
                    //       });
                    //     },
                    //     starBuilder: (index, color) => Icon(
                    //       Icons.star,
                    //       color: color,
                    //       size: 35,
                    //     ),
                    //     starCount: 5,
                    //     starSize: 35,
                    //
                    //     valueLabelRadius: 10,
                    //     maxValue: 5,
                    //     starSpacing: 2,
                    //     maxValueVisibility: false,
                    //     valueLabelVisibility:false,
                    //     animationDuration: Duration(milliseconds: 100),
                    //     valueLabelPadding:
                    //     const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    //     valueLabelMargin: const EdgeInsets.only(right: 8),
                    //     starOffColor: const Color(0xffe7e8ea),
                    //     starColor: Colors.yellow,
                    //   ),
                    // ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                  height: Get.height,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: mainColor,
                  )));
            }
          }),
    ));
  }
}
