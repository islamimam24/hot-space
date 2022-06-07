// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coworking_space/Screens/signin/sign_in.dart';
import 'package:coworking_space/Screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class MustSignin extends StatelessWidget {
  static String mustsigninID = 'must_signin';
  const MustSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' To use this feature you should.. ',
                textAlign: TextAlign.center,
                // style: TextStyle(fontSize: 16),
              ),
              InkWell(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignInScreen.signinId);
                },
              ),
            ],
          ),
          Text(
            "Or",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                " If you dont have an account, ",
              ),
              InkWell(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.signupID);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
