import 'package:flutter/material.dart';
import 'package:my_gradution_project/models/Category_model.dart';
import 'package:my_gradution_project/widgets/Category_card.dart';


class category_listview extends StatelessWidget {
  category_listview({
    super.key,
  });

  final List<CategoryModel> categories = [
    CategoryModel(
        image: 'assets/PharaonicAntiquities.jpeg',
        categoryname: 'PharaonicAntiquities'),
    CategoryModel(
        image: 'assets/Islamicantiquities.jpg',
        categoryname: 'Islamicantiquities'),
    CategoryModel(
        image: 'assets/NatureReserves.jpg', categoryname: 'natureReserves'),
    CategoryModel(image: 'assets/Oases.jpg', categoryname: 'Oases'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Category_card(
          category: categories[index],
        );
      },
    );
  }
}
