import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

//ignore: must_be_immutable
class Decrypt extends StatefulWidget {
  Decrypt(this.time, this.name, this.msg);
  String time;
  String name;
  String msg;
  @override
  _DecryptState createState() => _DecryptState();
}

class _DecryptState extends State<Decrypt> {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String pfpurl;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.name)
        .get()
        .then((value) {
      setState(() {
        pfpurl = value.data()['pfp'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String decoded = stringToBase64.decode(widget.msg);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Palette().bluebg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 44.0),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sent an aurora "),
                    Text(
                      widget.time.toString().substring(0, 16),
                      style: TextStyle(fontSize: 12, color: Colors.white54),
                    )
                  ],
                ),
                leading: CircleAvatar(
                  backgroundImage: MemoryImage(base64Decode(pfpurl)),
                  radius: 20,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: Color(0xff16213A)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(decoded),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
