import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/data/FirestoreService.dart';
import 'package:my_gradution_project/data/firestore.dart';
import 'package:my_gradution_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

class comment_screen extends StatefulWidget {
  final String postid;
  const comment_screen({super.key, required this.postid});

  @override
  State<comment_screen> createState() => _comment_screenState();
}

class _comment_screenState extends State<comment_screen> {
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<Userprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'comment',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(widget.postid)
                    .collection('comments').orderBy('date',descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState==ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> commentmap =
                        snapshot.data!.docs[index].data();
                      return ListTile(
                        title:  Text(commentmap['name']),
                        subtitle: Text(commentmap['comment']),
                        leading:  CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                               commentmap['userimage'])),
                               
                        
                      );
                    },
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(userprovider.getuser!.userimage)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (comment.text != '') {
                                  Firestoremethod().addcomment(
                                      comment: comment.text,
                                      userimage:
                                          userprovider.getuser!.userimage,
                                      uid: userprovider.getuser!.Uid,
                                      postid: widget.postid, name: userprovider.getuser!.username);
                                }
                                comment.text = '';
                              },
                              icon: Icon(Icons.send)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'add comment',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
