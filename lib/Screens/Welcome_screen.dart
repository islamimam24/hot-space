// ignore_for_file: unnecessary_new, prefer_const_constructors, use_key_in_widget_constructors, file_names, avoid_print, sort_child_properties_last, use_build_context_synchronously

import 'package:coworking_space/Screens/signin/sign_in.dart';
import 'package:coworking_space/Screens/signup/signup_screen.dart';
import 'package:coworking_space/home_screen/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:coworking_space/Screens/third_welcome_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static String secWelcomeScreenID = "sec_welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 300.0,
                      floating: true,
                      pinned: true,
                      snap: true,
                      actionsIconTheme: IconThemeData(opacity: 0.0),
                      flexibleSpace: Stack(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Positioned.fill(
                              child: Image.asset(
                            "images/coverr.jpg",
                            fit: BoxFit.cover,
                          )),
                        ],
                      ),
                    ),
                    // SliverPadding(
                    //   padding: new EdgeInsets.all(16.0),
                    //   sliver: new SliverList(

                    //   ),
                    // ),
                  ];
                },
                body: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Sharing Energy, Ideas and Spaces",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Why work alone when you could work together!",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          padding: 170,
                          textButton: "Sign up",
                          onTapFunc: () {
                            Navigator.pushNamed(context, SignUpScreen.signupID);
                          },
                        ),
                        CustomButton(
                          // color: Colors.green.shade600,
                          padding: 170,
                          gradientColor: kGreenGredient,
                          textButton: "Log In",
                          onTapFunc: () {
                            Navigator.pushNamed(context, SignInScreen.signinId);
                          },
                        ),
                      ],
                    ),
                    Text("OR"),
                    CustomButton(
                      // color: Colors.purple.shade800,
                      padding: 300,

                      textButton: "GET STARTED",
                      onTapFunc: () async {
                        await _auth.signInAnonymously();
                        Navigator.pushNamed(context, HomeScreen.homeScreenId);
                      },
                    ),
                  ],
                ))));
  }
}
