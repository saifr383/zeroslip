import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:untitled1/model/homemodel.dart';



import '../controller/authcontroller.dart';
import '../services/services.dart';
import '../utils/colors.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        body: FutureBuilder(
           future: Services.getHomeData(token: _authController.currentUser!.access),
          builder: (context,AsyncSnapshot<HomeModel> snapshot) {

             if(snapshot.hasData)
             {
               var time=DateTime.now().hour;
print((snapshot.data!.profileCompleted).toDouble());
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        time>3&&time<12?'Good Morning!':time<17?'Good Afternoon!':'Good Night!',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${snapshot.data!.customer.substring(0,4)}-${snapshot.data!.customer.substring(4)}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffe3edff)),
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/homeicon1.svg',
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RIP Paper Receipts',
                                  style:
                                      TextStyle(color: mainColor, fontSize: 18),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    'Save your planet and trees. Always request for ZeroSlip Smart Receipt.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){_authController.navcontroller.jumpToTab(3);},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffe3ffef)),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${snapshot.data!.profileCompleted}%',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff088b4c)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    padding: EdgeInsets.all(8),
                                    child:  SvgPicture.asset(
                                      'assets/images/homeicon2.svg',
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'PROFILE COMPLETED',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              LinearPercentIndicator(
                                width: Get.width*0.8,
                                lineHeight: 10.0,
                                percent: (snapshot.data!.profileCompleted).toDouble()/100.0,
                                linearGradient:LinearGradient(colors:  [mainColor,buttonColor]),

                              backgroundColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: (){_authController.navcontroller.jumpToTab(1);},

                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffffeae9)),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total\nSpending',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    padding: EdgeInsets.all(8),
                                    child:   SvgPicture.asset(
                                      'assets/images/homeicon3.svg',
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Rs ${snapshot.data!.totalSpendings}',
                                style:
                                    TextStyle(fontSize: 18, color: buttonColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){_authController.navcontroller.jumpToTab(1);},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffede4ff)),
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total\nReceipts',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    padding: EdgeInsets.all(8),
                                    child:   SvgPicture.asset(
                                      'assets/images/homeicon4.svg',
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '${snapshot.data!.totalReceipts}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: buttonColor,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: ' Receipts',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
             else
             {
               return SizedBox(height:Get.height,child: Center(child: CircularProgressIndicator(color: mainColor,)));
             }
            }
        ),
      ),
    );
  }
}
