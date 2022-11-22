// ignore_for_file: camel_case_types, avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  CollectionReference userserf = FirebaseFirestore.instance.collection("users");
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

// methode 1 show data body
  /* List users = [];
  DocumentReference userOneserf = FirebaseFirestore.instance
      .collection("users")
      .doc("kpmhgoxNX2hIzz6gKadr");
  getOneDoc() async {
    var responsebody = await userOneserf.get();
    setState(() {
      users.add(responsebody.data());
    });
  

   CollectionReference userserf = FirebaseFirestore.instance.collection("users");
  getAllDocs() async {
    var responsebody = await userserf.get();
    responsebody.docs.forEach((element) {
      setState(() {
        users.add(element.data());
      });
    });
    print(users);
  }*/

  /*
  // Batch Write faire des operations a plus que doc
  DocumentReference docwone =
      FirebaseFirestore.instance.collection("users").doc("154551254");
  DocumentReference doctow = FirebaseFirestore.instance
      .collection("users")
      .doc("kpmhgoxNX2hIzz6gKadr");

  batchWrite() {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    batch.delete(docwone);
    batch.update(doctow, {"name": "khaloud"});
    batch.commit();
  }

  // transaction lorsque tu veus assure que tous les champs modifier
  DocumentReference userdoc = FirebaseFirestore.instance
      .collection("users")
      .doc("kpmhgoxNX2hIzz6gKadr");
  trans() {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      // start trans
      DocumentSnapshot docsnap = await transaction.get(userdoc);
      if (docsnap.exists) {
        transaction.update(userdoc, {"age": 33});
      } else {
        print("User no exict");
      }
      //end
    });
  }

  deleteDoc() async {
    CollectionReference userserf =
        FirebaseFirestore.instance.collection("users");
    await userserf
        .doc("Z3hljb74LKQgDytOndNS")
        .delete()
        .then((value) => {print("delete succeful")})
        .catchError((e) {
      print("Error : $e");
    });
  }

  udpdateDoc() async {
    CollectionReference userserf =
        FirebaseFirestore.instance.collection("users");
    //userserf.doc("AJMa22lwXiY7bCFA0Qir").update({"name": "khalid"});

    await userserf
        .doc("AJMa22lwXiY7bCFA0Qir")
        .set({"name": "hamid"}, SetOptions(merge: true)).then((value) {
      print("update succeful");
    }).catchError((e) {
      print("Error : $e");
    });
  }

  addDoc() async {
    CollectionReference userserf =
        FirebaseFirestore.instance.collection("users");
    //await userserf.add({"email": "hamid@gmail.com", "name": "hamid", "age": 123265623});

    await userserf.doc("154551254") // determiner userId
        .set({"email": "khalil@gmail.com", "name": "khalil", "age": 1456656});
  }

  getOneDoc() async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection("users")
        .doc("Z3hljb74LKQgDytOndNS");
    doc.get().then((value) {
      print(value.data());
    });
  }

  getdata() async {
    /* FirebaseFirestore.instance.collection("users").get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
          })
        });*/

    /*CollectionReference userserf = FirebaseFirestore.instance.collection("users");
     QuerySnapshot querySnapshot = await userserf.get();
    List<QueryDocumentSnapshot> listdocs = querySnapshot.docs;
    listdocs.forEach((element) {
      print(element.data());
    });*/

    /* CollectionReference userserf =
        FirebaseFirestore.instance.collection("users");
    await userserf
    // where pour recherche 
    // pour faire recherche a deux champs  au plus where().where()...
    // isEqualTo = / isGreaterThan > / isLessThan < / isGreaterThanOrEqualTo >= / isLessThanOrEqualTo <= / wehreIn=[] / pour array (arrayContains = "" / arrayContainsAny=[]) 
        .where("age" /* champ*/ , isLessThanOrEqualTo: 20)
        .get()
        .then((value) {
      
      value.docs.forEach((element) {
        print(element.data());
      });
    });*/

    /*CollectionReference userserf =
        FirebaseFirestore.instance.collection("users");
    await userserf
        // orderBy pour order de classement
        // descending (false classement  moin a plus , true c'est plus a moin )
        // limit determiner limit de resultat , startAt([20]) c'est a partir de 20 , startAfter([20])c'set apres de 20, endAt([20]) terminer a 20 , endBefore c'est avant de 20
        .orderBy("age", descending: false)
        .limit(1)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });*/

    // Real Time = lorsque en modifier  data base le changement faire directement
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data()['name']);
      });
    });
  }*/

  @override
  /* void initState() {
    //getdata();
    getOneDoc();
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Test")),
        body:
            //StreamBuilder lorsque on faire changement en firebase il change directement a flutter (apploication)
            StreamBuilder(
          stream: notesref.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, i) {
                    return Text("${snapshot.data.docs[i].data()['title']}");
                  }));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )

        //FutureBuilder
        /*FutureBuilder(
          future: userserf.get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, i) {
                    return ListTile(
                      title: Text("${snapshot.data.docs[i].data()['name']}"),
                      subtitle: Text("${snapshot.data.docs[i].data()['age']}"),
                    );
                  }));
            }
            return Center(child: CircularProgressIndicator());
          },
        )*/

        /*users == null || users.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: ((context, i) {
                  return Text("name : ${users[i]["name"]}");
                }))*/

        /*Column(children: [
        Center(
          child: ElevatedButton(
              onPressed: (() {
                getdata();
                /* 
               getdata();
                getOneDoc();
                addDoc();
                udpdateDoc();
                deleteDoc();
                trans();
                batchWrite();
                */
              }),
              child: Text("get data")),
        )
      ]),*/
        );
  }
}
