import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../utils/firebaseUtils.dart';
import '../utils/userInfos.dart';
import 'chatConversationSingleMessage.dart';

class ChatConversationMessages extends StatefulWidget {
  final UserInfos userdata;
  final ScrollController scrollController;
  //List<Message> messagesFirebase;
  ChatConversationMessages({
    //required this.messagesFirebase,
    required this.scrollController,
    required this.userdata,
  });

  @override
  _ChatConversationMessagesState createState() =>
      _ChatConversationMessagesState(
          scrollController: scrollController, userdata: userdata);
  //messagesFirebase: messagesFirebase);
}

class _ChatConversationMessagesState extends State<ChatConversationMessages> {
  bool isExecutedScroll = false;
  UserInfos userdata;
  ScrollController scrollController;
  List<Message> messagesFirebase = [];

  _ChatConversationMessagesState({
    //required this.messagesFirebase,
    required this.scrollController,
    required this.userdata,
  });

  FirebaseUtils fbUtils = FirebaseUtils();
  bool loaded = false;

  late StreamSubscription<QuerySnapshot> msgSubscription;

//dispose in cui fare unsubrìscribe listener

  @override
  void initState() {
    super.initState();

    callRetrieveMessagesFirebase();

    scrollController.addListener(() async {
      double minScroll = scrollController.position.minScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (minScroll == currentScroll) {
        callRetrieveMoreMessagesFirebase();
      }
    });
  }

  @override
  void dispose() {
    msgSubscription.cancel();
    super.dispose();
  }

  void callRetrieveMessagesFirebase() async {
    setState(() {
      loaded = false;
    });
    messagesFirebase = await fbUtils.retrieveMessagesFirebase(userdata.id);
    if (isExecutedScroll == false) {
      WidgetsBinding.instance!.addPostFrameCallback((_) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent));
      isExecutedScroll = true;
    }
    setState(() {
      loaded = true;
    });
    callUpdateMessages();
  }

  void callUpdateMessages() async {
    if (messagesFirebase.length != 0) {
      msgSubscription = fbUtils.updateMessages(
          userdata.id, messagesFirebase.last.createdAt, callBackMessages);
    } else if (messagesFirebase.length == 0) {
      msgSubscription = fbUtils.updateMessages(userdata.id,
          DateTime.now().millisecondsSinceEpoch.toString(), callBackMessages);
    }
  }

  void callBackMessages(DocumentChangeType typeAction, Message newMsg) {
    print('entrato callback');
    print('tA $typeAction');
    print('d $newMsg');
    if (typeAction.toString() == 'DocumentChangeType.added') {
      messagesFirebase.add(newMsg);

      setState(() {});
    } else if (typeAction.toString() == 'DocumentChangeType.removed') {
      print('entrato remove');
      messagesFirebase.removeWhere((item) =>
          (item.createdAt == newMsg.createdAt &&
              item.senderId == newMsg.senderId));
      setState(() {});
    } else if (typeAction.toString() == 'DocumentChangeType.modified') {
      print('modified');
      setState(() {});
    }
  }

  void callRetrieveMoreMessagesFirebase() async {
    setState(() {
      loaded = false;
    });
    //passa ultimo messaggio
    List<Message> addedMessages = await fbUtils.retrieveMoreMessagesFirebase(
        userdata, messagesFirebase.first.createdAt);

    for (int h = 0; h < addedMessages.length; h++) {
      messagesFirebase.insert(h, addedMessages[h]);
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        loaded == false
            //allign
            ? Positioned(
                left: 200,
                bottom: 760,
                child: Container(
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Container(),
        ListView.builder(
          key: Key('messageList'),
          controller: scrollController,
          itemCount: messagesFirebase.length,
          //shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 130,
          ),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ChatConversationSingleMessage(messagesFirebase[index]);
          },
        ),
      ],
    );
  }
}
