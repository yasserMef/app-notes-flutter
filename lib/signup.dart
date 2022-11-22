// ignore_for_file: prefer_const_constructors, deprecated_member_use, body_might_complete_normally_nullable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'compenents/alert.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var username;
  var email;
  var password;
  var credential;

  GlobalKey<FormState> formState = new GlobalKey<FormState>();

  signup() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("The password provided is too weak."))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "error",
              body: Text("The account already exists for that email."))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("no valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sign Up')),
      body: ListView(children: [
        Image.asset(
          "images/logoo.png",
          width: 200,
          height: 200,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formState,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (text) {
                    username = text;
                  },
                  validator: (val) {
                    int x = 4;
                    if (val == null || val.length > 100) {
                      return "username can't to be larger to 100 letter";
                    }
                    if (val == null || val.length < 2) {
                      return "username can't to be less to 2 letter";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "username",
                      prefixIcon: Icon(Icons.person),
                      labelText: "username"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "email",
                      prefixIcon: Icon(Icons.person),
                      labelText: "email"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    password = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "password",
                      prefixIcon: Icon(Icons.person),
                      labelText: "password"),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text("if you have account"),
                      InkWell(
                        child: Text(
                          'click here',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("signIn");
                        },
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () async {
                      var response = await signup();
                      if (response != null) {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .add({"username": username, "email": email});
                        print(response);
                        Navigator.of(context).pushReplacementNamed("homepage");
                      } else {
                        print(" Sign Up failed !!");
                      }
                    },
                    child: Text("sing up"))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
