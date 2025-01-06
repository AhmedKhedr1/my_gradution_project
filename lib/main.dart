import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:my_gradution_project/Screens/Chatbot_screen.dart';
import 'package:my_gradution_project/Screens/Home_screen.dart';
import 'package:my_gradution_project/Screens/Login_screen.dart';
import 'package:my_gradution_project/Screens/Map_screen.dart';
import 'package:my_gradution_project/Screens/Register_screen.dart';
import 'package:my_gradution_project/Screens/Reviews_screen.dart';
import 'package:my_gradution_project/Screens/Start_screen.dart';
import 'package:my_gradution_project/Screens/Welcome_screen.dart';
import 'package:my_gradution_project/Screens/profile_screen.dart';
import 'package:my_gradution_project/Screens/search_screen.dart';
import 'package:my_gradution_project/constns.dart';
import 'package:my_gradution_project/firebase_options.dart';
import 'package:my_gradution_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: GEMINI_API_KEY);

/*
  StoreData storedata=StoreData();
  storedata.addDataToFirestore(Islamicantiquities,'Islamicantiquities');
  storedata.addDataToFirestore(PharaonicAntiquities,'PharaonicAntiquities');
  storedata.addDataToFirestore(natureReserves,'natureReserves');
  storedata.addDataToFirestore(Oases,'Oases' );
  storedata.addDataToFirestore(General,'General' );
*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
           return Userprovider();
        },)
      ],
      child: MaterialApp(
        darkTheme: ThemeData.light(),
          routes: {
            Login_screen.id: (context) => const Login_screen(),
            Start_screen.id: (context) => const Start_screen(),
            Welcome_screen.id: (context) => const Welcome_screen(),
            Register_screen.id: (context) => const Register_screen(),
            Home_screen.id: (context) => const Home_screen(),
            cahtbot_screen.id: (context) => const cahtbot_screen(),
            Map_screen.id: (context) => const Map_screen(),
            Reviews_screen.id: (context) =>  Reviews_screen(),
            profile_screen.id: (context) =>  profile_screen(userid: FirebaseAuth.instance.currentUser!.uid),
            search_screen.id: (context) => const search_screen(),
          },
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('error');
              }
              if (snapshot.data == null) {
                return const Welcome_screen();
              }
              if (snapshot.hasData) {
                return const Home_screen();              
              }
              return const Welcome_screen();
            },
          )),
    );
  }
}
