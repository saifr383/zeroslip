import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  String text;Function onPress;

 CustomButton({
    Key? key,required this.onPress,required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 35),
      child: ElevatedButton(
          onPressed: (){this.onPress();},
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: const StadiumBorder(),
          ),
          child:  Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                this.text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Bai Jamjuree',
                    fontWeight: FontWeight.w700),
              ),
            ),
          )),
    );
  }
}