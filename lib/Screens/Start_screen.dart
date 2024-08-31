import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/Login_screen.dart';
import 'package:my_gradution_project/Screens/Register_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/widgets/custom_button.dart';

class Start_screen extends StatelessWidget {
  const Start_screen({super.key});
  static String id = 'start_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 80, bottom: 80),
            child: Text(
              'Plan your trips',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(flex: 1,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Login_screen.id);
            },
            child: custom_button(
              color: KPrimaryColor,
              button_text: 'Log in',
              text_color: BackgroundColor,
              Border_color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Register_screen.id);
            },
            child: Padding(
              padding: const EdgeInsets.only(top:30 ,bottom: 80),
              child: custom_button(
                color: BackgroundColor,
                button_text: 'Create account',
                text_color: SBackgroundColor,
                Border_color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
