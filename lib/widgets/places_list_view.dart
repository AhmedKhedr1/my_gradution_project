import 'package:flutter/material.dart';
import 'package:my_gradution_project/data/FirestoreService.dart';
import 'package:my_gradution_project/widgets/Place_list_tile.dart';

class PlaceListView extends StatefulWidget {
  final String collectionName;

  const PlaceListView({super.key, required this.collectionName});

  @override
  State<PlaceListView> createState() => _PlaceListViewState();
}

class _PlaceListViewState extends State<PlaceListView> {
  final FirestoreService _firestoreService = FirestoreService();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _firestoreService.getDataFromFirestore(widget.collectionName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final placesData = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: placesData.length,
            itemBuilder: (context, index) {
              final place = placesData[index];
              return place_list_tile(place: place);
            },
          );
        }
      },
    );
  }
}
