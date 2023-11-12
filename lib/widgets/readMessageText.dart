import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadMessageText extends StatelessWidget {
  final TextEditingController myController;
  final void Function() callback;

  final void Function() callbackPickImage;
  final void Function() callbackPickFile;

  ReadMessageText(
    this.myController,
    this.callback,
    this.callbackPickImage,
    this.callbackPickFile,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 2),
      height: 92,
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text('Select option'),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Select Image'),
                            onPressed: () {
                              callbackPickImage();
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Select File'),
                            onPressed: () {
                              callbackPickFile();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: myController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                callback();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}



// scegliere foto
// + apre libreria e seleziona una foto e la invia
// action sheet
// collgare callback per ogni tasto della list sheet