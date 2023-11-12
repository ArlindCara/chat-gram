import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfos {
  String id;
  String nickname;
  String about;
  List<String> pushTokens;

  UserInfos({
    required this.id,
    required this.nickname,
    required this.about,
    required this.pushTokens,
  });

  factory UserInfos.fromDocument(DocumentSnapshot doc) {
    String about = "";
    String nickname = "";
    List<String> pushTokens = [];
    try {
      about = doc.get('about');
    } catch (e) {}
    try {
      nickname = doc.get('nickname');
    } catch (e) {}
    try {
      pushTokens = doc.get('pushToken');
    } catch (e) {}

    return UserInfos(
      id: doc.id,
      nickname: nickname,
      about: about,
      pushTokens: pushTokens,
    );
  }
}
