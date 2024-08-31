import 'package:cloud_firestore/cloud_firestore.dart';

class StoreData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDataToFirestore(
      List<Map<String, dynamic>> data, String collectionName) async {
    final CollectionReference collection =
        _firestore.collection(collectionName);
    for (var item in data) {
      await collection.add(item);
    }
  }
  }