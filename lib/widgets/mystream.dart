// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunes_player_app/screens/chat.dart';
import 'package:tunes_player_app/widgets/messageline.dart';

final _firestore = FirebaseFirestore.instance;

class MyStreamBuilder extends StatelessWidget {
  const MyStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> widgetmessage = [];
          if (!snapshot.hasData) {
            // to return a grey box with the error if it is no data appeared in the screen
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            );
          }
          // reversed here is for keeping new messages dowen the chat
          final message = snapshot.data!.docs.reversed;
          for (var msg in message) {
            final msgText = msg.get('text');
            final msgSender = msg.get('sender');
            final current_user = signedInUser.email;
            final widget = MessageLine(
              txt: msgText,
              sender: msgSender,
              isMe: current_user == msgSender,
            );
            widgetmessage.add(widget);
          }
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView(
                reverse: true,
                children: widgetmessage,
              ),
            ),
          );
        });
  }
}
