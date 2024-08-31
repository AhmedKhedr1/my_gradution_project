import 'package:cloud_firestore/cloud_firestore.dart';

class user_model {
  final String username, email, password,userimage,Uid;
  final List followers;
  final List following;

  user_model(
    this.followers,
    this.following, this.userimage, {
    required this.username,
    required this.email,
    required this.password,
    required this.Uid,
  });

  Map<String, dynamic> converttomap() {
    return {
      'password': password,
      'email': email,
      'username': username,
      'userimage':userimage,
      'Uid': Uid,
      'followers': followers,
      'following': following
    };
  }

  static ConvertSnapToModel(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return user_model( snapshot['followers'], snapshot['following'],snapshot['userimage'],
        username: snapshot['username'],
        email: snapshot['email'],
        password: snapshot['password'],
        Uid: snapshot['Uid']);
  }
}
