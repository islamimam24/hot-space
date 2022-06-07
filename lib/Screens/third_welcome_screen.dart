// // ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

// import 'package:coworking_space/constants.dart';
// import 'package:flutter/material.dart';
// import 'signup_screen.dart';

// class ThirdWelcomeScreen extends StatelessWidget {
//   static String thirdScreen = "thirdWelcomeScreen";
//   // const HomeScreen({ Key? key }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 25),
//                 child: Text(
//                   "you're using this app as: ",
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               CustomButton(
//                 color: Colors.transparent,
//                 gradientColor: const [
//                   Color(0xff8E2DE2),
//                   Color(0xff4A00E0),
//                 ],
//                 textButton: "User",
//                 onTapFunc: () {
//                   Navigator.pushNamed(context, SignUpScreen.usersId);
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Text("or ", style: kTextHome),
//                 ),
//               ),
//               CustomButton(
//                 color: Colors.green.shade600,
//                 textButton: "Facility",
//                 onTapFunc: () {},
//               ),
//             ]),
//       ),
//     );
//   }
// }
