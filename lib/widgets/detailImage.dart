import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../models/message.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  Message? singleMessage;

  DetailScreen(Message singleMessagePassed) {
    this.singleMessage = singleMessagePassed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          child: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'imageZoomed',
              child: PhotoView(
                imageProvider: NetworkImage(singleMessage!.imageUrl.toString()),
              ),
            ),
          ),
          Positioned(
              top: 35,
              left: 25,
              child: Container(
                  height: 30.0,
                  width: 30.0,
                  child: FloatingActionButton(
                      child: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })))
        ],
      )
          /*
          Column(children: <Widget>[
        FloatingActionButton(
            child: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        Center(
          child: Hero(
            tag: 'imageZoomed',
            child: PhotoView(
              imageProvider: NetworkImage(singleMessage!.imageUrl.toString()),
            ),
          ),
        ),
      ]
      */
          ),
    );
  }
}
