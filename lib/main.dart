// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:tunes_player_app/screens/chat.dart';
import 'package:tunes_player_app/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tunes_player_app/screens/register.dart';
import 'package:tunes_player_app/screens/sign_in.dart';

void main() async {
  // to link this app with the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // apikey is in  the project settings at the firebase
      apiKey: "AIzaSyC9IU50jmH0onQS0w5ZrDMLphjdBp4YkqM",
      // appid in the project settings at the firebase
      appId: "1:458394438362:android:07f70f95d24d6741e0b3e3",
      // messagingsenderid is in the user and permessions / cloud messaging
      messagingSenderId: "458394438362",
      // project id is in the project settings at the firebase
      projectId: "message-me-56f70",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageME',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home:const  WelcomeScreen(),
      initialRoute: _auth.currentUser != null
          ? Chat.screenRoute
          : WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        // 'signin_screen':(context)=>const SignIn(),
        SignIn.screenRoute: (context) => const SignIn(),
        Register.screenRoute: (context) => const Register(),
        Chat.screenRoute: (context) => const Chat(),
      },
    );
  }
}
