// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('sign Up')),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "images/logo.png",
              width: 200,
              height: 200,
            ),
            TextFormField(
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
                    onTap: () {},
                  )
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                onPressed: () {},
                child: Text("sing up"))
          ]),
        ));
  }
}
