import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String chatroomId;
  String createdAt;
  String? message;
  String senderId;
  String? imageUrl;
  String? fileUrl;

  Message({
    required this.chatroomId,
    required this.createdAt,
    required this.message,
    required this.senderId,
    required this.imageUrl,
    required this.fileUrl,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    String chatroomId = "";
    String createdAt = "";
    String? message;
    String senderId = "";
    String? imageUrl;
    String? fileUrl;
    
    try {
      chatroomId = doc.get('chatroomId');
    } catch (e) {
      throw Exception("chatroomId not found");
    }
    try {
      createdAt = doc.get('createdAt');
    } catch (e) {
      throw Exception("createdAt not found");
    }
    try {
      message = doc.get('message');
    } catch (e) {
      print('message not found');
    }
    try {
      senderId = doc.get('senderId');
    } catch (e) {
      throw Exception("senderId not found");
    }
    try {
      imageUrl = doc.get('imageUrl');
    } catch (e) {
      print('imageUrl not found');
    }
    try {
      fileUrl = doc.get('fileUrl');
    } catch (e) {
      print('imageUrl not found');
    }

    return Message(
      chatroomId: chatroomId,
      createdAt: createdAt,
      message: message,
      senderId: senderId,
      imageUrl: imageUrl,
      fileUrl: fileUrl,
    );
  }
}
