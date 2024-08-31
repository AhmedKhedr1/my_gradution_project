import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/add_post_screen.dart';
import 'package:my_gradution_project/Screens/search_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/provider/user_provider.dart';

import 'package:my_gradution_project/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class Reviews_screen extends StatefulWidget {
   Reviews_screen({super.key});
  static String id = 'ReviewsScreen';

  @override
  State<Reviews_screen> createState() => _Reviews_screenState();
}

class _Reviews_screenState extends State<Reviews_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userprovider=Provider.of<Userprovider>(context,listen: false);
    userprovider.fetchuser(userid: FirebaseAuth.instance.currentUser!.uid);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push((MaterialPageRoute(
                builder: (context) {
                  return add_post_screen();
                },
              )));
            },
            child: Icon(Icons.add)),
      ),
      appBar: AppBar(
        actions:<Widget> [
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return search_screen();
            },));
          }, icon: Icon(Icons.search))
        ],
        backgroundColor: KPrimaryColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').orderBy('date',descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState==ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text('Error');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String,dynamic>postmap=snapshot.data!.docs[index].data() as Map<String,dynamic>;
                  return  post_widget(postmap:postmap );
                },
              );
            }
          )
        ],
      )),
    );
  }
}
