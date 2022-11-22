// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class test2 extends StatefulWidget {
  const test2({super.key});

  @override
  State<test2> createState() => _test2State();
}

class _test2State extends State<test2> {
  late File file;
  final imagepicker = ImagePicker();

  uploadImage() async {
    var pickedImage = await imagepicker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      var nameimage = basename(pickedImage.path); //name image
      // start upload
      var random = Random().nextInt(10000000000);
      nameimage = "$random$nameimage";
      var refstorage = FirebaseStorage.instance.ref("images/$nameimage");
      await refstorage.putFile(file);
      var url = await refstorage.getDownloadURL();
      print(url);

      //end upload

    }
  }

  getImagesAndFolderName() async {
    var ref = await FirebaseStorage.instance
        .ref("images")
        .list(ListOptions(maxResults: 2));
    ref.items.forEach((element) {
      print("==============");
      print(element.name); // name image
    });
    /* ref.prefixes.forEach((element) {
      print("==============");
      print(element.name);// name folder
  }*/
  }

  @override
  void initState() {
    getImagesAndFolderName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test2")),
      body: Column(children: [
        Center(
          child: ElevatedButton(
              onPressed: () async {
                await uploadImage();
              },
              child: Text("Upload Image")),
        ),
      ]),
    );
  }
}
