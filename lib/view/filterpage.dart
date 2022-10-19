import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



import '../controller/filtercontroller.dart';
import '../utils/colors.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  FilterController _controller=Get.find<FilterController>();
   DateTime startScreen=DateTime(2019,1,1);
  DateTime endScreen=DateTime(2019,1,1);
  RangeValues valuescreen=RangeValues(0, 1);
  @override
  void initState() {

    startScreen=_controller.start.value;
    endScreen=_controller.end.value;
    valuescreen=_controller.values.value;
    _controller.screendropdown.value=_controller.dropdownvalue.value;
    _controller.screencategorydropdown.value=_controller.categorydropdownvalue.value;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
                    Row(
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
                    InkWell(
                      onTap: (){ Navigator.of(context).pop();},
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: mainColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT CATEGORY',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(border: Border.all(color: mainColor),borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Icon(Icons.store,size: 30,color: mainColor,),
                            Padding(
                              padding: const EdgeInsets.only(left: 35.0),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton(icon: Icon(Icons.keyboard_arrow_down_rounded,size: 25,color: mainColor,),

                                  items: _controller.category
                                      .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: 18,
                                          fontFamily: "Regular"),
                                    ),
                                    value: value,
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    _controller.screencategorydropdown.value=value.toString();
                                    setState((){});

                                  },


                                  value:  _controller.screencategorydropdown.value,
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT DATE',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () async {

                          final picked = await showDateRangePicker(
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: mainColor, // <-- SEE HERE
                                  ),

                                ),
                                child: child!,
                              );
                            },

                            context: context,

                            lastDate: DateTime.now(),
                            firstDate: new DateTime(2019),
                          );
                          if (picked != null && picked != null) {
                            startScreen=picked.start;
                            endScreen=picked.end;
                            setState(() {

                            });

                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 25,
                                color: mainColor,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                '${startScreen.year}/${startScreen.month}/${startScreen.day} - ${endScreen.year}/${endScreen.month}/${endScreen.day}',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 25,
                                color: mainColor,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'PRICE RANGE',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text('Rs ${valuescreen.start.toInt()}-${valuescreen.end.toInt()}',style: TextStyle(color: mainColor),)
                        ],
                      ),
                      SizedBox(height: 20,),

                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(activeTrackColor:mainColor,rangeThumbShape:  CircleThumbShape(thumbRadius: 10)),

                        child: RangeSlider(

                            inactiveColor: Colors.grey,
                            min: _controller.min,
                            max:_controller.max,
                            values: valuescreen,
                            onChanged: (value){
                              setState(() {
                                valuescreen =value;
                              });
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xfff5f5f5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SELECT STORE',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(border: Border.all(color: mainColor),borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Icon(Icons.store,size: 30,color: mainColor,),
                            Padding(
                              padding: const EdgeInsets.only(left: 35.0),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton(icon: Icon(Icons.keyboard_arrow_down_rounded,size: 25,color: mainColor,),

                                  items: _controller.store
                                      .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: 18,
                                          fontFamily: "Regular"),
                                    ),
                                    value: value,
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    _controller.screendropdown.value=value.toString();
                                    setState((){});

                                  },


                                  value:  _controller.screendropdown.value,
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        _controller.start.value=startScreen;
                       _controller.end.value=endScreen;
                       _controller.values.value=valuescreen;
                       _controller.dropdownvalue.value= _controller.screendropdown.value;
                       _controller.categorydropdownvalue.value=_controller.screencategorydropdown.value;
                       print(_controller.categorydropdownvalue.value== 'All');
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Align(
                          alignment: Alignment.center,
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                      onPressed: () async {

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(

                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: mainColor),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child:  Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Align(
                          alignment: Alignment.center,
                          child:  Text(
                            'Cancel',
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 25,
                                fontFamily: 'Bai Jamjuree',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CircleThumbShape extends RangeSliderThumbShape {

  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center, {required Animation<double> activationAnimation, required Animation<double> enableAnimation, bool? isDiscrete, bool? isEnabled, bool? isOnTop, TextDirection? textDirection, required SliderThemeData sliderTheme, Thumb? thumb, bool? isPressed}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = mainColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);

    // TODO: implement paint
  }



}