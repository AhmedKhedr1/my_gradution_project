// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getDataFromFirestore(String collectionName) async {
    final CollectionReference collection =_firestore.collection(collectionName);
    final QuerySnapshot snapshot = await collection.get();
    return snapshot.docs.map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
