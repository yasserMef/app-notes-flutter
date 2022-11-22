import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courseflutter/edite.dart';
import 'package:courseflutter/viewnote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var notes;
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            onPressed: (() {
              Navigator.of(context).pushNamed("addnote");
            })),
        appBar: AppBar(
          title: Text("home page"),
          actions: [
            IconButton(
                onPressed: (() async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed("signIn");
                }),
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: notesref
                .where("userid",
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: ((context, i) {
                      return Dismissible(
                          onDismissed: (direction) async {
                            await notesref
                                .doc(snapshot.data.docs[i].id)
                                .delete();
                            await FirebaseStorage.instance
                                .refFromURL(snapshot.data.docs[i].id)
                                .delete();
                          },
                          key: UniqueKey(),
                          child: ListNotes(
                            notes: snapshot.data.docs[i],
                            docid: snapshot.data.docs[i].id,
                          ));
                    }));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

class ListNotes extends StatelessWidget {
  final docid;
  final notes;
  const ListNotes({this.docid, this.notes});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return viewnote(
            notes: notes,
          );
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                    fit: BoxFit.fill, height: 80, "${notes['imageurl']}")),
            Expanded(
                flex: 3,
                child: ListTile(
                  title: Text("${notes['title']}"),
                  subtitle: Text("${notes['note']}"),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return editenote(
                            docid: docid,
                            list: notes,
                          );
                        }));
                      },
                      icon: Icon(Icons.update)),
                ))
          ],
        ),
      ),
    );
  }
}
