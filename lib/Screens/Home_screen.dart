// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/Chatbot_screen.dart';
import 'package:my_gradution_project/Screens/Login_screen.dart';
import 'package:my_gradution_project/Screens/Map_screen.dart';
import 'package:my_gradution_project/Screens/Reviews_screen.dart';
import 'package:my_gradution_project/Screens/profile_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/widgets/Category_Listview.dart';
import 'package:my_gradution_project/widgets/places_list_view.dart';

// ignore: camel_case_types
class Home_screen extends StatelessWidget {
  const Home_screen({super.key});
  static String id = 'Home screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(

        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: KPrimaryColor,
        actions:<Widget>[ 
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return const Login_screen();
            },));
          },
          icon:const Icon(Icons.logout),
        ),]
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: category_listview(),
                ),
                const PlaceListView(collectionName: 'General'),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
        
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, cahtbot_screen.id);
                  },
                  child:const Icon(Icons.chat)),
              label: 'chatbot'),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Map_screen.id);
                  },
                  child:const Icon(Icons.map_outlined)),
              label: 'map'),
               BottomNavigationBarItem(icon: GestureDetector(onTap:() {
                Navigator.pushNamed(context, Reviews_screen.id);
                 
               },child:const Icon(Icons.reviews_sharp)),label:'Reviews'),

               BottomNavigationBarItem(icon: GestureDetector(onTap:() {
                Navigator.pushNamed(context, profile_screen.id);
                 
               },child:const Icon(Icons.person)),label:'profile'),
               
        ],
      ),
      
    );
  }
}
