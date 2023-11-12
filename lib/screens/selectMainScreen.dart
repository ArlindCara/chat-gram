import 'package:chat_gram/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'channels.dart';
import 'homePage.dart';

class SelectMainScreen extends StatefulWidget {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  State<StatefulWidget> createState() {
    return _SelectMainScreen();
  }
}

class _SelectMainScreen extends State<SelectMainScreen> {
  int pageIndex = 0;
  String chats = "Chats";
  String channels = "Channels";
  String profile = "Profile";
  List<Widget> pageList = <Widget>[
    HomePage(),
    Channels(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.message),
            label: chats,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group_work),
            label: channels,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_box),
            label: profile,
          ),
        ],
      ),
    );
  }
}
