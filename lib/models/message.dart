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
      print('non trovato chatroomId');
      throw Exception("non trovato chatroomId");
    }
    try {
      createdAt = doc.get('createdAt');
    } catch (e) {
      print('non trovato createdAt');
      throw Exception("non trovato createdAt");
    }
    try {
      message = doc.get('message');
    } catch (e) {
      print('non trovato message');
    }
    try {
      senderId = doc.get('senderId');
    } catch (e) {
      print('non trovato senderId');
      throw Exception("non trovato senderId");
    }
    try {
      imageUrl = doc.get('imageUrl');
    } catch (e) {
      print('non trovato imageUrl');
    }
    try {
      fileUrl = doc.get('fileUrl');
    } catch (e) {
      print('non trovato imageUrl');
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
