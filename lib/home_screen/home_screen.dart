// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, prefer_final_fields, unused_import

import 'package:coworking_space/constants.dart';
import 'package:coworking_space/home_screen/home_tab/home_tabb.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:coworking_space/home_screen/map_tab/map_tab.dart';
import 'messenger_tab/messanger_tab.dart';
import 'package:coworking_space/home_screen/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

late User loggedInUser;
// FirebaseAuth _auth = FirebaseAuth.instance;
bool isOfferAtProfile = false;

class HomeScreen extends StatefulWidget {
  static String homeScreenId = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({ Key? key }) : super(key: key);

  // Future<void> navigationHandling() async {
  //   if (_auth.currentUser!.isAnonymous) {
  //     print("anonymosely");
  //   } else {
  //     print("user signed in ");
  //   }
  // }

  @override
  void initState() {
    Firebase.initializeApp();
    _onItemTapped(_selectedIndex);
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeTabb(),
    // MapTab(),

    MessengerTab(),
    MessengerTab(),

    ProfileTab(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        currentIndex: _selectedIndex,
        selectedItemColor: kDarkRed,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatsapp),
            label: 'Messanger',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

      // child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Hero(
      //         tag: 'logo',
      //         child: SizedBox(
      //           height: 60,
      //           child: Image.asset('images/logo.png'),
      //         ),
      //       ),
      //     ],
      //   )
      // ]),
    );
  }
}
