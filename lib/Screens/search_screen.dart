import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_gradution_project/Screens/profile_screen.dart';
import 'package:my_gradution_project/constns.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});
static String id = 'searchscreen';

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  final searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  
                });
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: KPrimaryColor,
                      )),
                  hintText: 'search',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: KPrimaryColor,
                      ))),
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: searchcontroller.text)
                .get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return profile_screen(userid: snapshot.data!.docs[index]['Uid'] );
                        },));
                      },
                      title: Text(
                        snapshot.data!.docs[index]['username'],
                        style:const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            snapshot.data!.docs[index]['userimage']),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
