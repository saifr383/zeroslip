import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:untitled1/services/services.dart';

import '../controller/authcontroller.dart';
import '../controller/filtercontroller.dart';
import '../model/receiptmodel.dart';
import '../model/storemode.dart';
import '../utils/colors.dart';
import 'filterpage.dart';
import 'receiptdetail.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {

  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  AuthController _authController = Get.find<AuthController>();
  FilterController _controller = Get.put(FilterController());
  DateTime previousmonth=DateTime(3000,12);
  @override
  void initState() {
    // TODO: implement initState
    getCategory();
    getStores();
    super.initState();
  }
  getStores() async {
    List<StoreModel> stores=await Services.getStores(token: _authController.currentUser!.access);
    stores.forEach((element) {_controller.store.add(element.name);});
  }
  getCategory() async {
    List<StoreModel> category=await Services.getCategory(token: _authController.currentUser!.access);
    category.forEach((element) {_controller.category.add(element.name);});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: Services.getReceipt(
                token:
                    _authController.currentUser!.access),
            builder: (context, AsyncSnapshot<List<ReceiptModel>> snapshot) {

              if (snapshot.hasData) {

                var groupByDate = groupBy(snapshot.data!, (ReceiptModel obj) => DateTime(obj.createdAt!.year,obj.createdAt!.month));
                List<DateTime> keys=groupByDate.keys.toList();

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Receipts',
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: FilterPage(),
                                  withNavBar:
                                      true, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/filtericon.svg',
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        snapshot.data!.isEmpty?SizedBox(

                          height: Get.height-150,width: Get.width,
                          child:   Center(child: Text('No receipt found',style: TextStyle(color: mainColor,fontSize: 25),)),
                        ): ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: groupByDate.length,
                          itemBuilder: (context, indexdate) {
                            return Column(
                              children: [
                                Container(
                                  margin:EdgeInsets.symmetric(vertical: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border:
                                      Border.all(color: mainColor.withOpacity(0.5), width: 1)),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '${months[keys[indexdate].month-1]} ${keys[indexdate].year}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: groupByDate[keys[indexdate]]!.length,
                                    itemBuilder: (context, index) {

                                      return Obx(() => (_controller.values.value.end >=
                                          groupByDate[keys[indexdate]]![index].grandTotal! &&
                                              _controller.values.value.start <=
                                                  groupByDate[keys[indexdate]]![index].grandTotal! &&
                                              (_controller.dropdownvalue.value == 'All' ||
                                                  _controller.dropdownvalue.value ==
                                                      groupByDate[keys[indexdate]]![index].merchant!
                                                          .name) &&((_controller.categorydropdownvalue.value== 'All' ||
                                          _controller.categorydropdownvalue.value ==
                                              groupByDate[keys[indexdate]]![index].merchant!
                                                  .name) )&&
                                              ((groupByDate[keys[indexdate]]![index].createdAt
                                                      !.millisecondsSinceEpoch) >=
                                                  _controller.start.value
                                                      .millisecondsSinceEpoch) &&
                                              ((groupByDate[keys[indexdate]]![index].createdAt
                                                      !.millisecondsSinceEpoch) <=
                                                  _controller.end.value
                                                      .millisecondsSinceEpoch))
                                          ? Column(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    pushNewScreen(
                                                      context,
                                                      screen: ReceiptDetail(
                                                        number: groupByDate[keys[indexdate]]![index].receiptNumber!,
                                                      ),
                                                      withNavBar:
                                                          true, // OPTIONAL VALUE. True by default.
                                                      pageTransitionAnimation:
                                                          PageTransitionAnimation.cupertino,
                                                    );
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.all(12),
                                                    margin:
                                                        EdgeInsets.symmetric(vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                        color: Color(0xfff5f5f5)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.white),
                                                          padding: EdgeInsets.all(8),
                                                          child:   SvgPicture.asset(
                                                            'assets/images/tagicon.svg',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              groupByDate[keys[indexdate]]![index]
                                                                  .merchant!.name!,
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight:
                                                                      FontWeight.bold),
                                                            ),
                                                            Text(
                                                              '${days[groupByDate[keys[indexdate]]![index].createdAt!.weekday - 1]}, ${groupByDate[keys[indexdate]]![index].createdAt!.day} ${months[groupByDate[keys[indexdate]]![index].createdAt!.month - 1]}',
                                                              style: TextStyle(
                                                                color: Color(0xff263238),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          '${groupByDate[keys[indexdate]]![index].merchant!.country!.currency!.denotion!.substring(0,2)} ${groupByDate[keys[indexdate]]![index].grandTotal}',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          )
                                          : SizedBox());
                                    }),
                              ],
                            );
                          }
                        )
                      ],
                    ),
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
      ),
    );
  }
}
