// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors, import_of_legacy_library_into_null_safe, avoid_print, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../signin/sign_in.dart';
import 'package:coworking_space/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  static String signupID = "users_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // =========( Declerated Variables )============//
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;

  // final usernameController = TextEditingController();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  String? fName;
  String? lName;
  // String? fullName = fName + " " + lName;
  String? usernameController;
  String? emailController;
  String? passwordController;
  bool showSpinner = false;

  // =========( Declerated Functions )============//
  String? usernameValidate(String? usernameForm) {
    if (usernameForm == null || usernameForm.isEmpty) {
      return " * Username field isRequired";
    } else if (usernameForm.length <= 3) {
      return "*must be more than 3 letters";
    } else {
      usernameController = usernameForm;
    }
    return null;
  }

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
    } else if (!RegExp(r'^(?=.*?[A-Z]).{8,}$').hasMatch(formPassword)) {
      return 'Password Must include an uppercase letter.';
    } else if (!RegExp(r'^(?=.*?[0-9]).{8,}$').hasMatch(formPassword)) {
      return 'Password Must include a number.';
    } else if (!RegExp(r'^(?=.*?[!@#\$&*~]).{8,}$').hasMatch(formPassword)) {
      return 'use at least on of !@#\$&*~';
    } else {
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

  final _formKey = GlobalKey<FormState>();
  // const Users({Key? key}) : super(key: key);
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
                "Sign Up",
                style: TextStyle(
                  color: kDarkRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomFormField(
                    // controllerText: usernameController,
                    icon: Icon(
                      Icons.account_circle,
                      size: 0,
                      color: kDarkRed,
                    ),

                    placeHolder: "First Name",
                    validator: usernameValidate,
                    onFieldSubmitted: (value) {
                      fName = value;
                    },
                    obscureText: false,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomFormField(
                    // controllerText: usernameController,
                    icon: Icon(
                      Icons.account_circle,
                      size: 0,
                      color: kDarkRed,
                    ),

                    placeHolder: "Last Name",
                    // ignore: body_might_complete_normally_nullable
                    validator: usernameValidate,

                    onFieldSubmitted: (value) {
                      lName = value;
                    },
                    obscureText: false,
                  ),
                )
              ],
            ),

            // =================(( username))===================w
            CustomFormField(
              // controllerText: usernameController,
              icon: Icon(
                Icons.account_circle,
                size: 35,
                color: kDarkRed,
              ),

              placeHolder: "Username",
              // ignore: body_might_complete_normally_nullable
              validator: usernameValidate,

              onFieldSubmitted: (value) {
                usernameController = value;
              },
              obscureText: false,
            ),
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
              icon: Icon(
                Icons.lock,
                size: 35,
                color: kDarkRed,
              ),
              placeHolder: "Password",
              // ignore: body_might_complete_normally_nullable
              validator: validatePassword,

              onFieldSubmitted: (value) {
                passwordController = value;
              },
            ),
            // =================(( Terms&condition))===================

            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_box,
                  color: kDarkRed,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "I read and agree to ",
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  child: Text("Terms & Conditions"),
                  onTap: () {},
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // =================(( Form Field))===================

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomElevatedButton(
                  color: Colors.transparent,
                  textButton: "CREATE ACCOUNT",
                  onTapFunc: () async {
                    // print("from pressed");
                    // print(usernameController.text);
                    // print(emailController.text);
                    // print(passwordController.text);
                    // ===================
                    try {
                      // ignore: unnecessary_brace_in_string_interps

                      if (_formKey.currentState!.validate()) {
                        await _auth.createUserWithEmailAndPassword(
                            email: emailController.toString(),
                            password: passwordController.toString());
                        await _auth.currentUser!.updateDisplayName(
                            fName.toString() + " " + lName.toString());
                        await _fireStore
                            .collection("users")
                            .doc(_auth.currentUser!.uid)
                            .set({
                          "Full Name":
                              (fName.toString() + " " + lName.toString()),
                          "Email": emailController,
                          "uid": _auth.currentUser!.uid,
                        });
                        Navigator.popAndPushNamed(
                            context, HomeScreen.homeScreenId);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        // print('The password provided is too weak.');
                        return alert('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        // print('The account already exists for that email.');
                        return alert(
                            'The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }

                    setState(() {});
                  }),
            ),

            // =================(( button))===================

            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an acount? ",
                  style: TextStyle(color: Colors.grey),
                ),
                InkWell(
                  child: Text("Sign in"),
                  onTap: () {
                    Navigator.pushNamed(context, SignInScreen.signinId);
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
