import 'package:flutter/material.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/widgets/places_list_view.dart';

class category_screen extends StatelessWidget {
  const category_screen({super.key, required this.category});

  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        title: Text(
          category,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: PlaceListView(collectionName: category))
          //
        ],
      ),
    );
  }
}
