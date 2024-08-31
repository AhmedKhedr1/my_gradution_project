import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_gradution_project/Screens/Home_screen.dart';
import 'package:my_gradution_project/Screens/Register_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/helper/show_snack_bar.dart';
import 'package:my_gradution_project/widgets/Custom_TextFiled.dart';
import 'package:my_gradution_project/widgets/custom_button.dart';

// ignore: camel_case_types
class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  static String id = 'login_screen';

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  bool isloading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  final email = TextEditingController();
  final password = TextEditingController();
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: BackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Custom_TextFiled.Custom_TextFormFiled(
                  controller: email,
                  hintText: 'Email',
                ),
                Custom_TextFiled.Custom_TextFormFiled(
                  controller: password,
                  hintText: 'Password',
                ),
                GestureDetector(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloading = true;
                      setState(() {});
                      try {
                        await Login_User();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return Home_screen();
                        },));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Show_Bar_Message(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          Show_Bar_Message(context,
                              'Wrong password provided for that user.');
                        }
                        isloading = false;
                        setState(() {});
                      }catch(e){
                        Show_Bar_Message(context, 'there was an error ');
                      }
                     isloading = false;
                     setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: custom_button(
                        color: KPrimaryColor,
                        button_text: 'Log in',
                        text_color: Colors.white,
                        Border_color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Register_screen.id);
                  },
                  child: custom_button(
                      color: Colors.white,
                      button_text: 'Sign up',
                      text_color: Colors.black,
                      Border_color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> Login_User() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  }
}
