import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/category_screen.dart';
import 'package:my_gradution_project/models/Category_model.dart';
class Category_card extends StatelessWidget {
   Category_card({
    super.key,
    required this.category
  });

final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder:  (context) {
          return category_screen(category: category.categoryname,);
        },));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height:100 ,
          width: 160,
          decoration: BoxDecoration(
            image:
                 DecorationImage(fit: BoxFit.fill,image: AssetImage(category.image)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
} 