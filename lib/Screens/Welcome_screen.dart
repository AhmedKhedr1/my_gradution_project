// ignore: file_names
import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/Login_screen.dart';
import 'package:my_gradution_project/Screens/Start_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/widgets/custom_button.dart';

// ignore: camel_case_types
class Welcome_screen extends StatelessWidget {
  const Welcome_screen({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/welcomeimage.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: 150,
                    height: 75, // Image radius
                    child: const Image(image: AssetImage('assets/Logo.png')),
                  )),
              const Text(
                'Travel Guide',
                style: TextStyle(
                  color: BackgroundColor,
                  fontSize: 35,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Start_screen.id);
                },
                child: custom_button(
                  color: KPrimaryColor,
                  button_text: 'Get started',
                  text_color: BackgroundColor,
                  Border_color: const Color(0xff157351),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Alredy have an account ? ',
                      style: TextStyle(
                        color: BackgroundColor,
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Login_screen.id);
                      },
                      child: const Text(
                        ' Log in ',
                        style: TextStyle(
                            color: BackgroundColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
