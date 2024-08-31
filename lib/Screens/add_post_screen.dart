import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/helper/show_snack_bar.dart';
import 'package:my_gradution_project/provider/user_provider.dart';
import 'package:my_gradution_project/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class add_post_screen extends StatefulWidget {
  const add_post_screen({super.key});

  @override
  State<add_post_screen> createState() => _add_post_screenState();
}

class _add_post_screenState extends State<add_post_screen> {
  File? pickedimage;
  final des = TextEditingController();
  void selectimage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    var selected = File(image!.path);
    if (image != null) {
      setState(() {
        pickedimage = selected;
      });
    }
  }

  Widget build(BuildContext context) {
    final userprovider = Provider.of<Userprovider>(context);

    void upload_post() async {
      try {
        final uuid = Uuid().v4();
        final ref = FirebaseStorage.instance
            .ref()
            .child('postimage')
            .child(uuid + 'jpg');
        await ref.putFile(pickedimage!);
        final imageurl = await ref.getDownloadURL();

        FirebaseFirestore.instance.collection('posts').doc( uuid).set({
          'username': userprovider.getuser!.username,
          'uid': userprovider.getuser!.Uid,
          'userimage': userprovider.getuser!.userimage,
          'imagepost': imageurl,
          'postid': uuid,
          'des': des.text,
          'likes':[],
          'date':Timestamp.now()
          
        });
        setState(() {
          pickedimage=null;
          des.text='';
        });
        Show_Bar_Message(context, 'done');
      } on FirebaseException catch (e) {
        Show_Bar_Message(context, Text(e.toString()) as String);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimaryColor,
        title: const Text(
          'Add Post',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              pickedimage == null
                  ? SizedBox(
                      height: 200,
                    )
                  : Image.file(
                      pickedimage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
              IconButton(
                  onPressed: () {
                    selectimage();
                  },
                  icon: const Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                        child: Icon(
                      Icons.upload,
                      size: 40,
                    )),
                  )),
              TextField(
                controller: des,
                maxLines: 8,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KPrimaryColor)),
                    hintText: 'add your post'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(onTap: () {
                  upload_post();
                },child: custom_button(color: KPrimaryColor, button_text: 'upload post' , text_color: Colors.white, Border_color: KPrimaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
