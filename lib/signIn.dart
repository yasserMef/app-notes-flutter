// ignore_for_file: deprecated_member_use, camel_case_types, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'compenents/alert.dart';

class signiIn extends StatefulWidget {
  const signiIn({super.key});

  @override
  State<signiIn> createState() => _signiInState();
}

class _signiInState extends State<signiIn> {
  var email;
  var password;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signiIn(context) async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('sign In')),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(children: [
            Image.asset(
              "images/logoo.png",
              width: 200,
              height: 200,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (text) {
                          email = text;
                        },
                        validator: (val) {
                          int x = 4;
                          if (val == null || val.length < 4) {
                            return "username can't to be less to 2 letter";
                          }
                          if (val.length > 100) {
                            return "username can't to be larger to 100 letter";
                          }
                          return null;
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
                            Text("if you don't have account"),
                            InkWell(
                              child: Text(
                                'click here',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed("signup");
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
                            var response = await signiIn(context);
                            if (response != null) {
                              Navigator.of(context)
                                  .pushReplacementNamed("homepage");
                            } else {
                              print("Sign In Failed");
                            }
                          },
                          child: Text("sing In"))
                    ],
                  )),
            )
          ]),
        ));
  }
}
