import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dart_date/dart_date.dart';

import '../models/message.dart';
import 'detailImage.dart';
import 'detailPdf.dart';

// ignore: must_be_immutable
class ChatConversationSingleMessage extends StatelessWidget {
  Message? singleMessage;

  ChatConversationSingleMessage(Message singleMessagePassed) {
    this.singleMessage = singleMessagePassed;
  }

  @override
  Widget build(BuildContext context) {
    // timestamp invio messaggio
    int timeInMillis = int.parse(singleMessage!.createdAt);
    // timestamp invio messaggio in formato data
    var dateMessage = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    // timestamp ora
    var now = DateTime.now();
    var formattedDate;
    if (!dateMessage.isSameDay(now)) {
      formattedDate = DateFormat.yMMMd().format(dateMessage);
    } else {
      formattedDate =
          dateMessage.hour.toString() + ':' + dateMessage.minute.toString();
    }

    //return singleMessage!.imageUrl != null ?

    //return singleMessage!.imageUrl != null || singleMessage!.message  != null ? Container(

    //)

    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment:
            (singleMessage!.senderId != FirebaseAuth.instance.currentUser!.uid
                ? Alignment.topLeft
                : Alignment.topRight),
        child: Container(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.10,
              maxWidth: MediaQuery.of(context).size.width * 0.60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(singleMessage!.senderId !=
                      FirebaseAuth.instance.currentUser!.uid
                  ? 0.0
                  : 15),
              bottomRight: Radius.circular(singleMessage!.senderId !=
                      FirebaseAuth.instance.currentUser!.uid
                  ? 15
                  : 0.0),
            ),
            color: (singleMessage!.senderId !=
                    FirebaseAuth.instance.currentUser!.uid
                ? Colors.grey.shade200
                : Colors.lightBlue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: singleMessage!.senderId ==
                    FirebaseAuth.instance.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              renderFile(singleMessage, context),
              SizedBox(height: 0),
              renderImage(singleMessage, context),
              SizedBox(height: 0),
              renderMessage(singleMessage),
              SizedBox(height: 0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.watch_later,
                    color: Colors.white,
                    size: 12.0,
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget renderImage(singleMessage, context) {
  if (singleMessage!.imageUrl != null) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Hero(
              tag: singleMessage!.createdAt,
              child: Image.network(
                singleMessage!.imageUrl.toString(),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailScreen(singleMessage!);
            }));
          },
        ));
  } else {
    return Container(
      width: 0,
      height: 0,
    );
  }
}

Widget renderMessage(singleMessage) {
  if (singleMessage!.message != null && singleMessage!.message!.isNotEmpty)
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(singleMessage!.message.toString(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            )));
  else
    return Container(
      width: 0,
      height: 0,
    );
}

Widget renderFile(singleMessage, context) {
  if (singleMessage!.fileUrl != null)
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          child: Container(
            // color: Colors.white,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Row(children: <Widget>[
                  Hero(
                    tag: singleMessage!.createdAt,
                    child: Image.network(
                      "https://findicons.com/files/icons/1579/devine/256/file.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(child: Text('file PDF')),
                ])),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return DetailPdf(singleMessage!.fileUrl);
            }));
          },
        ));
  else
    return Container(
      width: 0,
      height: 0,
    );
}


// 1) installare FCM e ottenere Token per identificare dispositivo
// 2) 
// aggiungere lista token [array] con tutti i dispositivi usati dall'utente

