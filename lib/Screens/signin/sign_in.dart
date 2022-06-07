// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:email_validator/email_validator.dart';
import '../../home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  static String signinId = "sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // const SignInScreen({ Key? key }) : super(key: key);
  // =========( Declerated Variables )============//
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? emailController;
  String? passwordController;
  bool showSpinner = false;
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // =========( Declerated Functions )============//
  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return " * Email-address is required";
    } else if (!EmailValidator.validate(formEmail)) {
      return "*Enter a valid email";
    } else {
      emailController = formEmail;
    }
    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return "*Password field is required.";
    } else if (formPassword.length <= 7) {
      return "*must be more than 7 letters";
    }
    // else if (!RegExp(r'^(?=.*?[A-Z]).{8,}$').hasMatch(formPassword)) {
    //   return 'Password Must include an uppercase letter.';
    // } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$').hasMatch(formPassword)) {
    //   return 'Password Must include an uppercase letter.';
    // } else if (!RegExp(r'^(?=.*?[!@#\$&*~]).{8,}$').hasMatch(formPassword)) {
    //   return 'use at least on of !@#\$&*~';
    // }
    else {
      passwordController = formPassword;
    }
    return null;
  }

  Future<dynamic> alert(String info) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(info),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        });
  }

  // // bool showSpinner = true;
  // Future<dynamic> spinner() {
  //     return showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Sign in",
                style: TextStyle(
                  color: kDarkRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )),

            // =================(( mail))===================
            CustomFormField(
              // controllerText: emailController,
              obscureText: false,
              icon: Icon(Icons.email, size: 35, color: kDarkRed),
              placeHolder: "Email",
              // ignore: body_might_complete_normally_nullable
              validator: validateEmail,
              onFieldSubmitted: (value) {
                emailController = value;
              },
            ),
            // =================(( password))===================
            CustomFormField(
              // controllerText: passwordController,
              obscureText: true,
              icon: Icon(Icons.lock, size: 35, color: kDarkRed),
              placeHolder: "Password",
              // ignore: body_might_complete_normally_nullable
              validator: validatePassword,
              onFieldSubmitted: (value) {
                passwordController = value;
              },
            ),
            // =================(( Terms&condition))===================

            SizedBox(
              height: 10,
            ),

            // =================(( Form Field))===================

            Builder(
              builder: (context) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CustomElevatedButton(
                      color: Colors.transparent,
                      textButton: "Sign in",
                      onTapFunc: () async {
                        // print("from pressed sign in");
                        // print(email);
                        // print(password);
                        // ===================
                        showSpinner = true;
                        try {
                          if (_formKey.currentState!.validate()) {
                            await _auth.signInWithEmailAndPassword(
                                email: emailController.toString(),
                                password: passwordController.toString());
                            await Navigator.pushNamed(
                                context, HomeScreen.homeScreenId);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            return alert('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            return alert(
                                'Wrong password provided for that user.');
                          }
                          showSpinner = false;
                        } catch (e) {
                          print(e);
                        }
                        setState(() {});
                      }),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
