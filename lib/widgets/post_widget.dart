import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gradution_project/Screens/comment_screen.dart';
import 'package:my_gradution_project/data/firestore.dart';

class post_widget extends StatelessWidget {
  post_widget({super.key, required this.postmap});
  final Map<String, dynamic> postmap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(postmap['userimage'])),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(postmap['username'],
                    style: TextStyle(
                      fontSize: 22,
                    )),
              ),
            ],
          ),
          Image.network(
            postmap['imagepost'],
            height: 250,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Firestoremethod().addlike(postmap: postmap);
                  },
                  icon: Icon(Icons.favorite,
                      color: postmap['likes']
                              .contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Colors.red
                          : Colors.grey)),
              IconButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return comment_screen(postid: postmap['postid']);
                },));
              }, icon: const Icon(Icons.comment)),
            ],
          ),
          Text(
            '${postmap['likes'].length}likes',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            postmap['des'],
            style: TextStyle(fontSize: 18),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return comment_screen(postid: postmap['postid'],);
                  },
                ));
              },
              child: const Text('Add Comment')),
           Text(DateFormat.jm().format(postmap['date'].toDate()), style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}
