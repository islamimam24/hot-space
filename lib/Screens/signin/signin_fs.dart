// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:coworking_space/constants.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';

class SigninFID extends StatelessWidget {
  static String signinFID = "signin_fs";
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
                "Log In",
                style: kHeaderText,
              )),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                color: Colors.transparent,
                textButton: "USER",
                onTapFunc: () {
                  Navigator.pushNamed(context, SignInScreen.signinId);
                },
              ),
              CustomButton(
                textButton: "OWNER",
                onTapFunc: () {},
              ),
            ]),
      ),
    );
  }
}
