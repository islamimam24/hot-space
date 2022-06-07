// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, duplicate_ignore, sort_child_properties_last, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coworking_space/home_screen/home_tab/add_offer.dart';
// import 'package:coworking_space/home_screen/messenger_tab/messanger_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coworking_space/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'offer_card.dart';
import 'package:coworking_space/Screens/signin/sign_in.dart';
import 'package:coworking_space/Screens/signup/signup_screen.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_view/split_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:coworking_space/home_screen/home_screen.dart';

final List<String> imgList = [
  "images/Vila.jpeg",
  "images/weWork.jpeg",
  "images/HotSpace.jpeg",
  "images/cowork.jpeg",
  "images/Vila.jpeg",
  "images/ModernSpace.jpeg"
];

// bool showProgress = false;

final List<Widget> offerCard = [];

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class HomeTabb extends StatefulWidget {
  static String homeTabId = "home_tab";
  @override
  State<HomeTabb> createState() => _HomeTabbState();
}

class _HomeTabbState extends State<HomeTabb> {
  bool showSpinner = false;

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 1000.0,
                      height: 350,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20.0),
                        // color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  imgList[imgList.indexOf(item)]
                                      .replaceAll("images/", "")
                                      .replaceAll(".jpeg", ""),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '10 LE/hr',
                                  style: TextStyle(
                                    color: kDarkRed,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cairo',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffcc00),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffcc00),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffcc00),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFffcc00),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kDarkRed,
          elevation: 15,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return AddOfferBottomSheet();
                });
          },
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(color: kDarkRed),
          child: SafeArea(
            child: SplitView(viewMode: SplitViewMode.Vertical, children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Hot Space",
                          style: TextStyle(
                              color: kDarkRed,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: Icon(Icons.search),
                            color: Colors.grey.shade300,
                            shape: CircleBorder(side: BorderSide.none),
                            minWidth: 10,
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Icon(Icons.whatsapp),
                            color: Colors.grey.shade300,
                            shape: CircleBorder(side: BorderSide.none),
                            minWidth: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Discover Your WorkSpace",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: imageSliders,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                // showSpinner = true;
                              });
                              // Navigator.pushNamed(context, WorkSpaces.seeAllId);
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkRed),
                              textAlign: TextAlign.start,
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "Offers",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kDarkRed),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ModalProgressHUD(
                      inAsyncCall: showSpinner, child: OfferStreem())
                ],
              ),
            ]),
          ),
        ));
  }

  // =================== (((((( BOTTOM SHEET))))))==============

  // bottomSheet(BuildContext context) {}
}
//   Future<dynamic> bottomSheet(BuildContext context) {
//     return
//   }
// }

// ========================(((((((((OFFER STREAM)))))))))===================

class OfferStreem extends StatefulWidget {
  const OfferStreem({Key? key}) : super(key: key);

  @override
  State<OfferStreem> createState() => _OfferStreemState();
}

class _OfferStreemState extends State<OfferStreem> {
  num? wsOfferPrice;
  bool showSpinner = false;

  num? offerPriceCalc(String numb1, String numb2) {
    final wsOfferPrice = int.parse(numb1) * (1 - (int.parse(numb2) / 100));
    return wsOfferPrice;
  }

  @override
  Widget build(BuildContext context) {
    isOfferAtProfile = false;

    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection("workspaces").snapshots(),
        builder: (context, snapshot) {
          List<Widget> offerCard = [];
          try {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: kDarkRed,
                  backgroundColor: kDarkRed,
                ),
              );
            } else {
              final allData = snapshot.data!.docs;
              for (var data in allData) {
                final imageURL = data.get("profile_PIC");
                final name = data.get('name');
                final city = data.get('city');
                final price = data.get('price');
                final offerDiscount = data.get('offerDiscount');
                // final offerPrice = offerPriceCalc(price, offerDiscount);
                final offerPrice =
                    offerPriceCalc(price.toString(), offerDiscount.toString());
                final cardSample = OfferCard(
                    imageURL, name, city, price, offerDiscount, offerPrice!,
                    () async {
                  if (_auth.currentUser!.isAnonymous) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text("Warning"),
                              content:
                                  Text("to use this feature please sign in"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, SignUpScreen.signupID);
                                  },
                                  isDefaultAction: true,
                                  child: Text("sign up"),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, SignInScreen.signinId);
                                  },
                                  child: Text("sign in"),
                                )
                              ],
                            ));
                  } else {
                    // setState(() {
                    //   showSpinner = true;
                    // });

                    await _fireStore
                        .collection("users")
                        .doc(_auth.currentUser!.uid)
                        .collection("booking")
                        .doc()
                        .set({
                      "imageURL": imageURL,
                      "name": name,
                      "city": city,
                      "price": price,
                      "offerDiscount": offerDiscount,
                      "offerPrice": offerPrice
                    });
                  }
                });
                offerCard.add(cardSample);
                // showSpinner = false;
              }
            }
          } on Exception catch (e) {
            // ignore: avoid_print
            print(e);
          }

          return Expanded(
            child: ListView(
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              children: offerCard,
            ),
          );
        });
  }
}
