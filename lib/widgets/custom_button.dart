import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: camel_case_types, must_be_immutable
class custom_button extends StatelessWidget {
 Color color;
 Color text_color;
 Color Border_color;
 String button_text;

   custom_button({super.key, 
    required this.color,
    required this.button_text,
    required this.text_color,
    required this.Border_color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.fromBorderSide(BorderSide(color: Border_color,width: 2)),
          color: color,
        ),
        child:  Center(
            child: Text(
          button_text,
          style: TextStyle(color: text_color,fontSize: 18),
        )),
      ),
    );
  }
}
