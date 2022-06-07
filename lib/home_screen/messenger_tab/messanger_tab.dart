// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking_space/Screens/must_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:coworking_space/home_screen/messenger_tab/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:coworking_space/constants.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// import 'package:image_picker/image_picker.dart';

final _auth = FirebaseAuth.instance;
// final _fireStore = FirebaseFirestore.instance;
String? imageURL;

bool showSpinner = false;

class MessengerTab extends StatefulWidget {
  const MessengerTab({Key? key}) : super(key: key);

  @override
  State<MessengerTab> createState() => _MessengerTabState();
}

class _MessengerTabState extends State<MessengerTab> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    Firebase.initializeApp();
    _getData();
    super.initState();
    // getCurrentUser();
  }

  Future<void> _getData() async {
    final data = await _fireStore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.data());
    // print(data![stringValue]);
    // if (bioSec != null) {
    // } else {}

    setState(() {
      // fullName = data!["Full Name"];
      // phoneSec = data["phone No"];
      // bioSec = data["bio Field"];
      imageURL = data!["profile_PIC"];

      // userID = data["uid"];
      showSpinner = true;
    });
  }

// just to check if there is current user sighned in
  // void getCurrentUser() async {
  //   try {
  //     if (!_auth.currentUser!.isAnonymous) {
  //     } else {}
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser!.isAnonymous) {
      return MustSignin();
    } else if (showSpinner != true) {
      return ProgressHUD(child: Center(child: CircularProgressIndicator()));
    } else {
      return Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Chat",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: MaterialButton(
              colorBrightness: Brightness.light,
              elevation: 10,
              color: kLightRed,
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.chatScreenID);
              },
              child: ChatContainer(),
            ),
          ),
        ],
      );
    }
  }
}

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageURL ??
                "https://firebasestorage.googleapis.com/v0/b/cowork-3f13c.appspot.com/o/user_images%2Fprofile.jpg?alt=media&token=54c37ed7-8365-428b-a2da-d44b17a213fa"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _auth.currentUser!.email.toString(),
                  style: TextStyle(
                    // color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text("last message sent shown here ..")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
