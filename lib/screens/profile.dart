import 'package:chat_gram/screens/splashScreen.dart';
import 'package:flutter/material.dart';

import '../utils/firebaseUtils.dart';
import '../utils/userInfos.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/profilePictureWidget.dart';
import 'editProfile.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  bool loaded = false;

  FirebaseUtils fbUtils = FirebaseUtils();

  late String nickname;
  late String about;

  @override
  void initState() {
    super.initState();
    getUsersInfo();
  }

  void getUsersInfo() async {
    UserInfos user = await fbUtils.retrieveUserDataFirebase();

    setState(() {
      nickname = user.nickname;
      about = user.about;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: loaded == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),

              children: [
                ProfilePictureWidget(
                  //imagePath: user.imagePath,
                  onClicked: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                    setState(() {
                      getUsersInfo();
                    });
                  },
                ),
                const SizedBox(height: 60),
                renderUserName(),
                const SizedBox(height: 90),
                renderUserAbout(),
                const SizedBox(height: 60),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black12),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      ),
                    ),
                    onPressed: () async {
                      if (await fbUtils.logoutGoogle() == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()),
                        );
                      }
                      setState(() {});
                    },
                    child: const Text('Logout'))
              ],
            ),
    );
  }

  Widget renderUserName() => Column(
        children: [
          Text(
            //user.name.toString(),
            nickname,

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          /*
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          ),
          */
          const SizedBox(height: 43),
        ],
      );

  Widget renderUserAbout() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
