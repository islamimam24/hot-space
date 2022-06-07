// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, sort_child_properties_last, use_build_context_synchronously

// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking_space/Screens/Welcome_screen.dart';
import 'package:coworking_space/constants.dart';
import 'package:coworking_space/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// import 'package:coworking_space/home_screen/home_screen.dart';
import '../home_tab/offer_card.dart';
import 'profile_editing.dart';
import '../../Screens/must_signin.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:split_view/split_view.dart';

// import 'dart:io';
late String sentBio;
late String sentPhoneNo;
late String sentImageURL;
String? userID;

late String sentFullName;
final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;
// final _fireStorage = FirebaseStorage.instance;
bool showSpinner = false;
num? offerPriceCalc(String numb1, String numb2) {
  final wsOfferPrice = int.parse(numb1) * int.parse(numb2) / 100;
  return wsOfferPrice;
}

class ProfileTab extends StatefulWidget {
  static String profileID = "profile_tab";

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? bioSec = "Add your bio here..";
  String? phoneSec = "";
  String? imageURL;
  String? fullName = _auth.currentUser!.displayName;
  // late AnimationController controller;

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
      fullName = data!["Full Name"];
      phoneSec = data["phone No"];
      bioSec = data["bio Field"];
      imageURL = data["profile_PIC"];
      userID = data["uid"];
      showSpinner = true;
    });
  }

  @override
  void initState() {
    Firebase.initializeApp();
    _getData();
    if (fullName != null &&
        imageURL != null &&
        bioSec != "Add your bio here..") {
      super.initState();
    }
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
  // Widget floatingButton() {
  //   return Builder(builder: (context, snap) {
  //     return MessageBuble(
  //       text: phoneSec.toString(),
  //       sender: "islam",
  //     );
  //   });
  // }

  Widget profile() {
    if (_auth.currentUser != null) {
      return (Column(
        children: [
          Text(_auth.currentUser!.email.toString()),
          Text(phoneSec.toString() == "null" ? "" : phoneSec.toString()),
          Padding(
            padding:
                const EdgeInsets.only(top: 24, left: 35, right: 35, bottom: 16),
            child: Text(
              bioSec.toString() == "null"
                  ? "Add your bio here.."
                  : bioSec.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  child: Text("Edit Profile"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    sentBio = bioSec.toString();
                    sentPhoneNo = phoneSec.toString();
                    sentImageURL = imageURL ??
                        "https://firebasestorage.googleapis.com/v0/b/cowork-3f13c.appspot.com/o/user_images%2Fprofile.jpg?alt=media&token=54c37ed7-8365-428b-a2da-d44b17a213fa";
                    sentFullName = fullName.toString();
                    // print(widget.sentBio);
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ProfileEditing((fullNameEdit, bioFieldEdit,
                              phoneSecEdit, imageURLEdit) {
                            fullName = fullNameEdit;
                            imageURL = imageURLEdit;
                            bioSec = bioFieldEdit;
                            phoneSec = phoneSecEdit;
                            // if (bioFieldEdit != null) {
                            // }
                            // if (phoneSecEdit != null) {
                            // }

                            setState(() {});
                          });
                        },
                        isScrollControlled: true);

                    setState(() {});
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    child: Text("Sign out"),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pushNamed(
                          context, WelcomeScreen.secWelcomeScreenID);
                    },
                  )),
            ],
          ),
        ],
      ));
    } else {
      return (Column(
        children: [
          InkWell(
            highlightColor: kLightRed,
            onTap: () {
              ///
            },
            child: Text(
              _auth.currentUser!.email.toString(),
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 24, left: 35, right: 35, bottom: 16),
            child: Text(
              bioSec.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          OutlinedButton(
            child: Text("Message"),
            onPressed: () async {
              print("user id : $userID ");
              print("current user id : ${_auth.currentUser!.uid}");
              await _fireStore
                  .collection("chats")
                  .doc(userID! + _auth.currentUser!.uid)
                  .collection("messages")
                  .add({
                // 'text': messageText,
                // 'sender': loggedInUser.email,
                'time': FieldValue.serverTimestamp(),
              });
            },
          )
        ],
      ));
    }
  }

  Widget phoneNo() {
    if (_auth.currentUser != null || phoneSec != null) {
      return SizedBox.shrink();
    } else {
      return (Builder(builder: (context) {
        return FloatingActionButton(
            backgroundColor: Colors.green.shade700,
            elevation: 15,
            tooltip: 'Phone No',
            child: const Icon(Icons.phone_in_talk_rounded),
            onPressed: () {
              // ignore: deprecated_member_use
              Scaffold.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: kDarkRed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.whatsapp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse('https://wa.me/+2$phoneSec');
                                  await launchUrl(url);
                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(phoneSec.toString())),
                          ],
                        ),
                      ],
                    )),
              );
            });
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser!.isAnonymous) {
      return MustSignin();
    } else if (showSpinner != true) {
      return ProgressHUD(child: Center(child: CircularProgressIndicator()));
    } else {
      isOfferAtProfile = true;

      return SafeArea(
          child: Scaffold(
        floatingActionButton: phoneNo(),
        body: Center(
          child: SplitView(viewMode: SplitViewMode.Vertical, children: [
            Column(mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      fullName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: kDarkRed,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {},
                        child: CircleAvatar(
                          radius: 67,
                          backgroundImage: NetworkImage(imageURL ??
                              "https://firebasestorage.googleapis.com/v0/b/cowork-3f13c.appspot.com/o/user_images%2Fprofile.jpg?alt=media&token=54c37ed7-8365-428b-a2da-d44b17a213fa"),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    fullName.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  profile(),
                  Divider(
                    thickness: 0.5,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(child: BookingStream()),
                ]),
          ]),
        ),
      ));
    }
  }

  ///
  ///
  ///
  ///
  ///
  ///
// =================================
  Future<void> picBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            height: 150,
            child: Column(children: [
              MaterialButton(
                  onPressed: () {
                    // getPhoto(ImageSource.gallery);
                    // setState(() {});
                  },
                  child: SizedBox(
                    width: 350,
                    child: Center(
                      child: Text(
                        'Select profile picture',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
              MaterialButton(
                  onPressed: () {},
                  child: SizedBox(
                      width: 350,
                      child: Center(
                        child: Text(
                          'view profile picture',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ))),
            ]),
          );
        });
  }
}

// Future<void> profileEditing(BuildContext context) {
//   return showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return ProfileEditing();
//       });
// }

// =============================

class BookingStream extends StatelessWidget {
  const BookingStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection("booking")
            .snapshots(),
        builder: (context, snapshot) {
          isOfferAtProfile = true;

          List<Widget> bookingStream = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: kDarkRed),
            );
          } else {
            final allData = snapshot.data!.docs;
            for (var data in allData) {
              final imageURL = data.get("imageURL");
              final name = data.get('name');
              final city = data.get('city');
              final price = data.get('price');
              final offerDiscount = data.get('offerDiscount');
              // final offerPrice = offerPriceCalc(price, offerDiscount);
              final offerPrice =
                  offerPriceCalc(price.toString(), offerDiscount.toString());
              final cardSample = OfferCard(
                imageURL,
                name,
                city,
                price,
                offerDiscount,
                offerPrice!,
                () {},
              );
              bookingStream.add(cardSample);
            }
          }
          return Expanded(
            child: ListView(
              children: bookingStream,
            ),
          );
        });
  }
}
