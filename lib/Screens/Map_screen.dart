// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/helper/show_snack_bar.dart';

class Map_screen extends StatefulWidget {

  const Map_screen({super.key});

static String id='Map_screen';

  @override
  State<Map_screen> createState() => _Map_screenState();
}

class _Map_screenState extends State<Map_screen> {
  final MapController mapController = MapController();
  TextEditingController searchController = TextEditingController();

  void zoomIn() {
    // ignore: deprecated_member_use
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void zoomOut() {
    // ignore: deprecated_member_use
    mapController.move(mapController.center, mapController.zoom - 1);
  }
void searchPlace(String query) async {
  List<Location> locations = await locationFromAddress(query);
  if (locations.isNotEmpty) {
    Location location = locations.first;
    mapController.move(LatLng(location.latitude, location.longitude), 15.0);
  } else {
    Show_Bar_Message(context, 'place not found now ,please try again ');
   
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimaryColor,
        title: const Text('Map',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: zoomIn,
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: zoomOut,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: const MapOptions(
              // ignore: deprecated_member_use
              center: LatLng(26.8206, 30.8025), 
              // ignore: deprecated_member_use
              zoom: 6.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding:const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration:const InputDecoration(
                        hintText: 'Search for a place',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => searchPlace(searchController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}