import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Channels extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Channels();
  }
}

class _Channels extends State<Channels> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePermanent = await saveImagePermanently(image.path);
      print('2');
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Center(
            child:
                ElevatedButton(onPressed: pickImage, child: Text("Get Image")),
          ),
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                )
              : Icon(
                  Icons.image,
                  size: 100,
                ),
        ],
      ),
    );
  }
}
