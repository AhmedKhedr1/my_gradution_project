import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_gradution_project/models/User_model.dart';
import 'package:uuid/uuid.dart';

class Firestoremethod {
  Future<user_model> userdetails({required userid}) async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    return user_model.ConvertSnapToModel(snap);
  }

  addlike({required Map postmap}) async {
    if (postmap['likes'].contains(FirebaseAuth.instance.currentUser!.uid)) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postmap['postid'])
          .update({
        'likes':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postmap['postid'])
          .update({
        'likes': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    }
  }

  addcomment(
      {required comment,
      required userimage,
      required uid,
      required postid,
      required name}) async {
    final uuid = Uuid().v4();

    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .doc(uuid)
        .set({
      'name': name,
      'comment': comment,
      'userimage': userimage,
      'uid': uid,
      'postid': postid,
      'commentid': uuid,
      'date':Timestamp.now(),
    });
  }

  follow_user({required userid}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'following': FieldValue.arrayUnion([userid])
    });

    await FirebaseFirestore.instance.collection('users').doc(userid).update({
      'following':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
  }

unfollow_user({required userid}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'following': FieldValue.arrayRemove([userid])
    });

    await FirebaseFirestore.instance.collection('users').doc(userid).update({
      'following':
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
    });
  }

}
