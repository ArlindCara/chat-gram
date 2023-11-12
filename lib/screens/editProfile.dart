import 'package:flutter/material.dart';

import '../utils/firebaseUtils.dart';
import '../utils/userInfos.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/profilePictureWidget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreen createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  late UserInfos user;
  late String nickname;
  late String about;
  late TextEditingController resetNameController = TextEditingController();
  late TextEditingController resetAboutController = TextEditingController();

  FirebaseUtils fbUtils = FirebaseUtils();

  @override
  void initState() {
    super.initState();
    getUsersInfo();
  }

  void getUsersInfo() async {
    user = await fbUtils.retrieveUserDataFirebase();
    nickname = user.nickname;
    about = user.about;
    resetNameController = TextEditingController(text: user.nickname);
    resetAboutController = TextEditingController(text: user.about);
    setState(() {
      resetNameController.text = nickname;
      resetAboutController.text = about;
    });
  }

  bool load = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfilePictureWidget(
              //imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            TextField(
              controller: resetNameController,
            ),
            const SizedBox(height: 24),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              //decoration: InputDecoration(hintText: '$userAbout'),
              controller: resetAboutController,
            ),
            const SizedBox(height: 34),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black12),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
              ),
              onPressed: () {
                //loader
                user.nickname = resetNameController.text;
                user.about = resetAboutController.text;
                fbUtils.updateNicknameAndAboutData(user);
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            )
          ],
        ),
      );
}
