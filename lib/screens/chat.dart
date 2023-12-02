// ignore_for_file: avoid_print, unused_field, unused_local_variable, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunes_player_app/screens/home.dart';
import 'package:tunes_player_app/widgets/mystream.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class Chat extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _auth = FirebaseAuth.instance;
  final msgtextcont = TextEditingController();
  String? messagetext;
  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

// function to get messages from firebase and print it in the commandline
  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // to listen to the messages that will be sent to the firebase
  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var msg in snapshot.docs) {
        print(msg.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Row(
              children: [
                Image.asset(
                  'images/home_bage.jpg',
                  height: 25,
                ),
                const SizedBox(width: 10),
                const Text('message me'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  //getMessages();
                  //messageStream();
                   _auth.signOut();
                   Navigator.popAndPushNamed(context ,WelcomeScreen.screenRoute);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          //AppBar
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const MyStreamBuilder(),
        
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                      color: Colors.orange,
                    ))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: msgtextcont,
                            // to save messages in the firestore database
                            onChanged: (value) {
                              messagetext = value;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              hintText: 'your message here...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            msgtextcont.clear();
                            //messageStream();
                            //to send messages to the firebasefirestore
                            _firestore.collection('messages').add({
                              'sender': signedInUser.email,
                              'text': messagetext,
                              'time':FieldValue.serverTimestamp(),
                            });
                          },
                          child: const Text(
                            'send',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )),
    );
  }
}

