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

class innerlist extends StatefulWidget {

  final String username;
  final String ukey;
  final String email;
  final String mobile;


  innerlist({
    required this.username,
    required this.ukey,
    required this.email,

    required this.mobile,

  });













  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<innerlist> {

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
    _messagesRef = FirebaseDatabase.instance.reference().child('messages').child(widget.ukey);
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
    print(widget.ukey);

    _messagesRef.orderByChild('receive').equalTo(userId).onValue.listen((event) {
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
                    'receive': userId,
                    'udkey': widget.ukey,
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
