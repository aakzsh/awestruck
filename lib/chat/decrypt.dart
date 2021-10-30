import 'package:awestruck/home.dart';
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
  @override
  Widget build(BuildContext context) {
    String decoded = stringToBase64.decode(widget.msg);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ListTile(
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
              subtitle: Text(decoded),
              leading: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
