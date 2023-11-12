import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/userInfos.dart';

class ChatConversationHeader extends StatelessWidget {
  final UserInfos userdata;
  ChatConversationHeader({
    required this.userdata,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png"),
            maxRadius: 20,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  userdata.nickname,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Online",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.black54,
              onPressed: () {}),
        ],
      ),
    );
  }
}
