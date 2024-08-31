import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_gradution_project/Screens/Login_screen.dart';
import 'package:my_gradution_project/models/User_model.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/helper/show_snack_bar.dart';
import 'package:my_gradution_project/widgets/Custom_TextFiled.dart';
import 'package:my_gradution_project/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class Register_screen extends StatefulWidget {
  const Register_screen({super.key});
  static String id = 'Register_screen';

  @override
  State<Register_screen> createState() => _Register_screenState();
}

class _Register_screenState extends State<Register_screen> {
  String imageurl =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  File? pickedimage;
  void selectimage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      setState(() {
        pickedimage = selected;
      });
    }
  }

  /*
  File? pickedimage;

  void selectimage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var selected = File(image!.path);
    if (image != null) {
      setState(() {
        pickedimage = selected;
      });
    }
  }
*/
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),
                const Center(
                  child: Text(
                    'Create account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      pickedimage != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundImage: FileImage(pickedimage!),
                            )
                          : const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                            ),
                      Positioned(
                          top: 25,
                          left: 25,
                          child: IconButton(
                              onPressed: () {
                                selectimage();
                              },
                              icon: Icon(Icons.add)))
                    ],
                  ),
                ),
                Custom_TextFiled.Custom_TextFormFiled(
                    controller: username, hintText: ' User Name '),
                Custom_TextFiled.Custom_TextFormFiled(
                    controller: email, hintText: ' E-mail '),
                Custom_TextFiled.Custom_TextFormFiled(
                    controller: password, hintText: ' Password '),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          if (pickedimage != null) {
                            final uuid = Uuid().v4();
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('usersimage')
                                .child(uuid + 'jpg');
                            await ref.putFile(pickedimage!);
                            final imageurl = await ref.getDownloadURL();
                          }
                          await Register_User();

                          user_model usermodel = user_model([], [], imageurl,
                              username: username.text,
                              email: email.text,
                              password: password.text,
                              Uid: FirebaseAuth.instance.currentUser!.uid);

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set(usermodel.converttomap());

                          Show_Bar_Message(context, 'sign up success ');
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Login_screen();
                            },
                          ));
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            Show_Bar_Message(
                                context, 'The password provided is too weak.');
                          } else if (ex.code == 'email-already-in-use') {
                            Show_Bar_Message(context,
                                'The account already exists for that email.');
                          }
                        }
                        isloading = false;
                        setState(() {});
                      }
                    },
                    child: custom_button(
                        color: KPrimaryColor,
                        button_text: 'Sign up',
                        text_color: Colors.white,
                        Border_color: KPrimaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ?',
                        style: TextStyle(fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Login_screen.id);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> Register_User() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
