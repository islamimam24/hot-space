// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:coworking_space/constants.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class SignupFID extends StatelessWidget {
  static String signupFID = "signup_fs";
  // const HomeScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Sign Up",
                style: kHeaderText,
              )),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                textButton: "User",
                onTapFunc: () {
                  Navigator.pushNamed(context, SignUpScreen.signupID);
                },
              ),
              CustomButton(
                textButton: "Owner",
                onTapFunc: () {},
              ),
            ]),
      ),
    );
  }
}
