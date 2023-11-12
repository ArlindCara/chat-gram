import 'dart:io';

import 'package:chat_gram/screens/photoMessageViewPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../models/message.dart';
import '../utils/firebaseUtils.dart';
import '../utils/userInfos.dart';
import '../widgets/chatConversationHeader.dart';
import '../widgets/chatConversationMessages.dart';
import '../widgets/readMessageText.dart';

class ChatConversationScreen extends StatefulWidget {
  final UserInfos userdata;

  ChatConversationScreen({
    required this.userdata,
  });

  @override
  _ChatConversationScreenState createState() =>
      _ChatConversationScreenState(userdata: userdata);
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  UserInfos userdata;

  _ChatConversationScreenState({
    required this.userdata,
  });

  final messageController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  FirebaseUtils fbUtils = FirebaseUtils();
  late Message tmpMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: ChatConversationHeader(userdata: userdata),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ChatConversationMessages(
            scrollController: _scrollController,
            userdata: userdata,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ReadMessageText(
              messageController,
              callSendMesage1,
              getImage,
              getFilePath,
            ),
          ),
        ],
      ),
    );
  }

  File? imageFile;

  void callSendMesage1() {
    //sendMess(textMessage);
    fbUtils.sendMessage(messageController, userdata);
    setState(() {
      messageController.text = '';
    });
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => PhotoMessageViewPage(
                      messageController,
                      imageFile!.path,
                      sendMessagePhoto,
                    )));
      }
    });
  }

  void sendMessagePhoto() {
    fbUtils.uploadPhotoAndMessage(imageFile, messageController.text, userdata);

    setState(() {
      messageController.text = '';
    });
  }

  Future getFilePath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;
    if (result != null) {
      setState(() {
        file = File(result.files.single.path as String);
      });
    }

    String fileName = file!.path.split('/').last;
    print('filePath $fileName');
    fbUtils.uploadFileFirebase(file, userdata);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    messageController.dispose();
    super.dispose();
  }
}
