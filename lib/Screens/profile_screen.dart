// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/data/firestore.dart';
import 'package:my_gradution_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key, required this.userid});
  final String userid;
  static String id = 'profile screen';
  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  late List following;
  late bool infollowing;
  bool isloading = false;
  late int postcount;

  void fetch_current_user() async {
    setState(() {
      isloading = true;
    });
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var snap = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: widget.userid)
        .get();

    postcount = snap.docs.length;
    following = snapshot.data()!['following'];
    setState(() {
      infollowing = following.contains(widget.userid);
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final userprovider = Provider.of<Userprovider>(context, listen: false);
    userprovider.fetchuser(userid: widget.userid);
    fetch_current_user();
  }

  Widget build(BuildContext context) {
    final userprovider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimaryColor,
      ),
      body: isloading == true
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       CircleAvatar(radius: 30, backgroundImage: NetworkImage(
                             userprovider.getuser!.userimage
                          )),
                       Column(
                        children: [
                          Text(
                            postcount.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          Text(
                            'post ',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${userprovider.getuser!.followers.length}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const Text(
                            'followers',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${userprovider.getuser!.following.length}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          const Text(
                            'following ',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      userprovider.getuser!.username,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: infollowing == true
                                ? Colors.red
                                : KPrimaryColor),
                        onPressed: () {
                          if (widget.userid == FirebaseAuth.instance.currentUser!.uid) {
                            
                          }
                          else if (infollowing == true) {
                            Firestoremethod()
                                .unfollow_user(userid: widget.userid);
                            userprovider.decrease_followers();
                            setState(() {
                              infollowing = false;
                            });
                          } else {
                            setState(() {
                              userprovider.increase_followers();
                              infollowing = true;
                            });
                            Firestoremethod()
                                .follow_user(userid: widget.userid);
                          }
                        },
                        child: widget.userid ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? const Text('Edit Profle',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
                            : infollowing == true
                                ? const Text('unfollow',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))
                                : const Text('follow',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.userid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('error');
                        }
                        return GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 5 / 4,
                            crossAxisCount: 3,
                            children: List.generate(snapshot.data!.docs.length,
                                (index) {
                              return Image.network(
                                snapshot.data!.docs[index]['imagepost'],
                                fit: BoxFit.fill,
                              );
                            }));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
