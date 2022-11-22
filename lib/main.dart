// ignore_for_file: prefer_const_constructors

import 'package:courseflutter/addnotes.dart';
import 'package:courseflutter/edite.dart';
import 'package:courseflutter/homepage.dart';
import 'package:courseflutter/signIn.dart';
import 'package:courseflutter/signup.dart';
import 'package:courseflutter/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'signIn.dart';

late bool islogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signiIn(),
      //islogin == false ? signiIn() : homepage(),
      routes: {
        "signup": (context) => signup(),
        "signIn": (context) => signiIn(),
        "homepage": (context) => homepage(),
        "addnote": (context) => addnote(),
        "editenote": (context) => editenote()
      },
    );
  }
}
