import 'package:flutter/material.dart';
import 'package:my_gradution_project/data/firestore.dart';
import 'package:my_gradution_project/models/User_model.dart';

class Userprovider with ChangeNotifier{

  user_model? userdata;
  user_model? get  getuser{

    return userdata;
  }
  void fetchuser({required userid})async{
    user_model user=await Firestoremethod().userdetails(userid: userid);
    userdata=user;
    notifyListeners();
    
  }

void increase_followers(){

  getuser!.followers.length++;
  notifyListeners();
}

void decrease_followers(){

  getuser!.followers.length--;
  notifyListeners();
}


}

