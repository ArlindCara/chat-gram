import 'package:flutter/material.dart';

import '../screens/chatConversationScreen.dart';
import '../utils/userInfos.dart';

class UsersList extends StatefulWidget {
  final UserInfos userdata;
  UsersList({
    required this.userdata,
  });

  final String messageText = 'hey';
  final String imageUrl =
      'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png';
  final String time = 'now';
  final bool isMessageRead = true;

  @override
  _UsersList createState() => _UsersList(userdata: userdata);
}

class _UsersList extends State<UsersList> {
  String messageText = 'hey';
  String imageUrl =
      'https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png';
  String time = 'now';
  bool isMessageRead = true;
  UserInfos userdata;
  _UsersList({
    required this.userdata,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatConversationScreen(userdata: userdata);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.imageUrl),
              maxRadius: 30,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.userdata.nickname,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.messageText,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: widget.isMessageRead
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
