import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/DetailsScreen.dart';

class place_list_tile extends StatefulWidget {
  const place_list_tile({
    key,
    required this.place,
  }) : super(key: key);

  final Map<String, dynamic> place;

  @override
  // ignore: library_private_types_in_public_api
  _PlaceListTileState createState() => _PlaceListTileState();
}

class _PlaceListTileState extends State<place_list_tile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(place: widget.place),
            ),
          );
        },
        child: Text(
          widget.place['name'],
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w900),
        ),
      ),
      subtitle: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(place: widget.place),
            ),
          );
        },
        child: Text(
          widget.place['description'],
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(place: widget.place),
            ),
          );
        },
        child:SizedBox(
          height: 65,
          width: 100,
          child: Image.network(
            widget.place['image'],
            fit: BoxFit.fill
          ),
        ),
      ),
    );
  }
}
