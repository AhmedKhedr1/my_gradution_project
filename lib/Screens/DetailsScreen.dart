import 'package:flutter/material.dart';
import 'package:my_gradution_project/constns.dart';


class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> place;

  const DetailsScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        title: Text(place['name'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(place['image'],fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Location: ${place['location']}',style:const TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(place['description'],style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
