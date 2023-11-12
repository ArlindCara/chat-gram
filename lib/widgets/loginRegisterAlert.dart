import 'package:flutter/material.dart';

void loginregisterAlert(
    {required String error, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(error),
        actions: <Widget>[
          TextButton(
            child: Text('Re-insert credentials'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
