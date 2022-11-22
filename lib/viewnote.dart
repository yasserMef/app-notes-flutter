import 'package:flutter/material.dart';

class viewnote extends StatefulWidget {
  final notes;
  const viewnote({super.key, this.notes});

  @override
  State<viewnote> createState() => _viewnoteState();
}

class _viewnoteState extends State<viewnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View")),
      body: Container(
          child: Column(
        children: [
          Container(
            child: Image.network(
              "${widget.notes['imageurl']}",
              height: 300,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${widget.notes["title"]}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              '${widget.notes["note"]}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          )
        ],
      )),
    );
  }
}
