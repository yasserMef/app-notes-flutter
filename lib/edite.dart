// ignore_for_file: unused_local_variable, deprecated_member_use, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/compenents/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class editenote extends StatefulWidget {
  final docid;
  final list;
  const editenote({Key? key, this.docid, this.list}) : super(key: key);

  @override
  State<editenote> createState() => _editenoteState();
}

class _editenoteState extends State<editenote> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  late File file;
  var title;
  var note;
  var imageurl;
  var ref;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  editenote(context) async {
    var formdata = formstate.currentState;
    if (file == null) {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();

        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
          "userid": FirebaseAuth.instance.currentUser?.uid
        });
        Navigator.of(context).pushNamed("homepage");
      }
    } else {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await ref.putFile(file);
        imageurl = await ref.getDownloadURL();
        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
          "imageurl": imageurl,
          "userid": FirebaseAuth.instance.currentUser?.uid
        }).then((value) {
          Navigator.of(context).pushNamed("homepage");
        }).catchError((e) {
          print("Error:$e");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Notes")),
        body: Form(
          key: formstate,
          child: Column(children: [
            TextFormField(
              initialValue: widget.list["title"],
              onSaved: (val) {
                title = val;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Title note",
                prefixIcon: Icon(Icons.note),
              ),
            ),
            TextFormField(
              initialValue: widget.list['note'],
              onSaved: (val) {
                note = val;
              },
              minLines: 1,
              maxLines: 3,
              maxLength: 300,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Title note",
                prefixIcon: Icon(Icons.note),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 200,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text("Please choose image"),
                              InkWell(
                                onTap: () async {
                                  var picked = await ImagePicker()
                                      .getImage(source: ImageSource.gallery);
                                  if (picked != null) {
                                    file = File(picked.path);
                                    var random = Random().nextInt(1000000);

                                    var nameimage =
                                        "$random" + basename(picked.path);
                                    ref = FirebaseStorage.instance
                                        .ref("images")
                                        .child(nameimage);
                                    // await ref.putFile(file);
                                    // imageurl = await ref.getDownloadURL();
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.image),
                                      Text("Form Gallery")
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  var picked = await ImagePicker()
                                      .getImage(source: ImageSource.camera);
                                  if (picked != null) {
                                    file = File(picked.path);
                                    var random = Random().nextInt(1000000);

                                    var nameimage =
                                        "$random" + basename(picked.path);
                                    ref = FirebaseStorage.instance
                                        .ref("images")
                                        .child(nameimage);
                                    //await ref.putFile(file);
                                    //imageurl = await ref.getDownloadURL();
                                    Navigator.of(context).pop();
                                  } else {}
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera),
                                      Text("Form camera")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Text("add Image for note")),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  editenote(context);
                },
                child: Text("Add Note"),
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
              ),
            )
          ]),
        ));
  }
}
