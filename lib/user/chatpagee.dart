import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseEvent {
  final String senderName;
  final String message;
  final int timestamp;

  DatabaseEvent({
    required this.senderName,
    required this.message,
    required this.timestamp,
  });
}

class ChatView extends StatefulWidget {

  final String pname;
  final String des;
  final String quantity;
  final String location;
  final String price;
  final String fname;
  final String address;
  final String fkey;
  final String udkey;
  final String category;
  final String image;

  ChatView({
    required this.pname,
    required this.des,
    required this.quantity,
    required this.location,
    required this.price,
    required this.fname,
    required this.address,
    required this.fkey,
    required this.udkey,
    required this.category,
    required this.image,
  });













  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user;
  late String userId;
  TextEditingController _messageController = TextEditingController();

  late DatabaseReference _messagesRef;
  late StreamController<List<DatabaseEvent>> _streamController;
  late Stream<List<DatabaseEvent>> _messagesStream;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    userId = user?.uid ?? "";
    _messagesRef = FirebaseDatabase.instance.reference().child('messages').child(userId);
    _streamController = StreamController<List<DatabaseEvent>>();
    _messagesStream = _streamController.stream;
    _listenToMessages();




  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _listenToMessages() {
    _messagesRef.orderByChild('timestamp').onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      List<DatabaseEvent> messages = [];

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic>? data = dataSnapshot.value as Map?;
        data?.forEach((key, value) {
          messages.add(DatabaseEvent(
            senderName: value['senderId'],
            message: value['message'],
            timestamp: value['timestamp'],



          ));
        });

        messages.sort((a, b) {
          return a.timestamp.compareTo(b.timestamp);
        });
      }

      _streamController.add(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<DatabaseEvent>>(
            stream: _messagesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<DatabaseEvent> messages = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(messages[index].senderName),
                      subtitle: Text(messages[index].message),
                    );
                  },
                );
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  String message = _messageController.text;
                  _messagesRef.push().set({

                    'senderId': userId,
                    'receive': widget.fkey,
                    'udkey': widget.udkey,
                    'message': message,

                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                  });
                  _messageController.clear();
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
      ],
    );
  }






}
