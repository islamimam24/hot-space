// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coworking_space/Screens/must_signin.dart';
import 'package:coworking_space/home_screen/home_tab/work_spaces.dart';
import 'package:coworking_space/home_screen/profile_tab/profile_tab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Screens/welcome_screen.dart';
import 'home_screen/home_screen.dart';
import 'Screens/signin/sign_in.dart';
import 'package:flutter/material.dart';
import 'Screens/signup/signup_screen.dart';

import 'home_screen/messenger_tab/chat_screen.dart';

import 'home_screen/home_tab/home_tabb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Hotspace",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(CoworkingSpace());
  // FlutterNativeSplash.remove();
}

class CoworkingSpace extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: Icons.home,
        nextScreen: WelcomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: PageTransitionType.scale,
        // backgroundColor: Colors.blue,
      ),
      // initialRoute: FirstWelcomeScreen.welcomeScreenID,
      routes: {
        WelcomeScreen.secWelcomeScreenID: (context) => WelcomeScreen(),
        // SignupFID.signupFID: (context) => SignupFID(),
        // SigninFID.signinFID: (context) => SigninFID(),
        // ThirdWelcomeScreen.thirdScreen: (context) => ThirdWelcomeScreen(),
        SignUpScreen.signupID: (context) => SignUpScreen(),
        SignInScreen.signinId: (context) => SignInScreen(),
        HomeScreen.homeScreenId: (context) => HomeScreen(),
        ChatScreen.chatScreenID: (context) => ChatScreen(),
        MustSignin.mustsigninID: (context) => MustSignin(),
        HomeTabb.homeTabId: (context) => HomeTabb(),
        WorkSpaces.seeAllId: (context) => WorkSpaces(),
        ProfileTab.profileID: (context) => ProfileTab(),
      },
    );
  }
}
