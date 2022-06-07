// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print, library_private_types_in_public_api, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coworking_space/constants.dart';
import 'package:coworking_space/home_screen/home_screen.dart';

// storing data on cloud
// outside any classes so we can use it all over the file.
final _auth = FirebaseAuth.instance;

final _firebaseStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static String chatScreenID = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

//  authirization the login and registration information
  final _auth = FirebaseAuth.instance;
//
  String messageText = '';

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    getCurrentUser();
  }

// just to check if there is current user sighned in
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() {
  //   // final messages = _firebaseStore.collection('messages').getDocuments();
  //   for (var message in messages) {
  //     print(message);
  //   }
  // }

// a very imprortant function
  void getMessagesStreem() async {
    await for (var snapshot in _firebaseStore
        .collection('chats')
        .doc(_auth.currentUser!.uid)
        .snapshots()) {
      for (var message in snapshot["messages"].docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                getMessagesStreem();
              }),
        ],
        title: Text(
          'Chat',
        ),
        backgroundColor: kDarkRed,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //  now we know that snapshot()method is returning a stream so wwe need somthing can handle a stream and create a list of text widgets for us.

            MessagesStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    color: kDarkRed,
                    shape: CircleBorder(side: BorderSide.none),
                    height: 45,
                    onPressed: () {
                      messageTextController.clear();
                      _firebaseStore
                          .collection("chats")
                          .doc(_auth.currentUser!.uid)
                          .collection('messages')
                          .add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Icon(
                      Icons.send,
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseStore
            .collection("chats")
            .doc(_auth.currentUser!.uid)
            .collection('messages')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          List<MessageBuble> messageBubles = [];

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: kDarkRed,
              ),
            );
          } else {
// accessing docs (text & sender) on snapshot firebase
            final messages = snapshot.data!.docs.reversed;
// we need to get them seperately to put them in a whole string like ((messageWidget))
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final currentUser = loggedInUser.email;
              final messageBubleSender = MessageBuble(
                text: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender,
              );
              messageBubles.add(messageBubleSender);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              children: messageBubles,
            ),
          );
        });
  }
}

// class MessageBuble extends StatelessWidget {
//   const MessageBuble({
//     Key? key,
//     this.text = '',
//     this.sender = '',
//     this.isMe = true,
//   }) : super(key: key);

//   // MessageBuble({
//   //   this.text,
//   //   this.sender,
//   //   this.isMe,
//   // });

//   final String text;
//   final String sender;
//   final bool isMe;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: [
//         Text(
//           sender,
//           style: TextStyle(
//             color: Colors.black54,
//             fontSize: 12,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: 8),
//           child: Material(
//             borderRadius: BorderRadius.only(
//               topLeft: isMe ? Radius.circular(15) : Radius.circular(0),
//               topRight: isMe ? Radius.circular(0) : Radius.circular(15),
//               bottomLeft: Radius.circular(15),
//               bottomRight: Radius.circular(15),
//             ),
//             elevation: 5,
//             color: isMe ? kDarkRed : Colors.grey.shade500,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 text,
//                 style: TextStyle(fontSize: 15, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }





            //   final messageBubleSender = MessageBuble(
            //     text: messageText,
            //     sender: messageSender,
            //     messageColor: Colors.lightBlueAccent,
            //     position: CrossAxisAlignment.end,
            //     topLeft: Radius.circular(15),
            //     // isMe: currentUser == messageSender,
            //   );
            //   final messageBubleOtherUser = MessageBuble(
            //     text: messageText,
            //     sender: messageSender,
            //     messageColor: Colors.black87,
            //     position: CrossAxisAlignment.start,
            //     topRight: Radius.circular(15),
            //   );
            //   if (currentUser == messageSender) {
            //     messageBubles.add(messageBubleSender);
            //   } else {
            //     messageBubles.add(messageBubleOtherUser);
            //   }
            // }
