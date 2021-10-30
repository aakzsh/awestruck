import 'dart:convert';

import 'package:awestruck/chat/messaging.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:awestruck/chat/msgData.dart';
import 'package:awestruck/home.dart';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class NewAurora extends StatefulWidget {
  NewAurora(this.roomId);
  String roomId;

  @override
  _NewAuroraState createState() => _NewAuroraState();
}

String lmao;
String content;

class _NewAuroraState extends State<NewAurora> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Palette().bluebg,
        child: Container(
          // color: Palette().bluebg.withOpacity(0.8),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Create New Aurora",
                style: TextStyle(
                    color: Palette().auroraGreen,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  color: Colors.blue.withOpacity(0.2),
                  height: 200,
                  width: 300,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(
                        decoration:
                            InputDecoration.collapsed(hintText: "Type here"),
                        onChanged: (text) {
                          lmao = text;
                        },
                        maxLines: 10,
                      ))),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                minWidth: 150,
                color: Palette().auroraGreen,
                onPressed: () {
                  content = stringToBase64.encode(lmao);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewAuroraSend(widget.roomId)));
                },
                child: Text(
                  "Encrypt",
                  style: TextStyle(color: Palette().bluebg),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewAuroraSend extends StatefulWidget {
  NewAuroraSend(this.roomId);
  String roomId;

  @override
  _NewAuroraSendState createState() => _NewAuroraSendState();
}

class _NewAuroraSendState extends State<NewAuroraSend> {
  DatabaseReference _messagesRef;
  DatabaseReference _firebaseref = FirebaseDatabase(
          databaseURL:
              'https://awestruck-d86c7-default-rtdb.asia-southeast1.firebasedatabase.app')
      .reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Palette().bluebg,
        child: Container(
          // color: Palette().bluebg.withOpacity(0.8),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Send Aurora",
                style: TextStyle(
                    color: Palette().auroraGreen,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  color: Colors.blue.withOpacity(0.2),
                  height: 200,
                  width: 300,
                  child: Padding(
                      padding: EdgeInsets.all(20), child: Text(content))),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                minWidth: 150,
                color: Palette().auroraGreen,
                onPressed: () {
                  //send and navigate to messaging
                  final msgData = MsgData(
                      author: username,
                      message_body: content,
                      time: DateTime.now().toString(),
                      aurora: true,
                      sticker: null);
                  _firebaseref
                      .child(widget.roomId)
                      .push()
                      .set(msgData.toMap())
                      .then((value) {
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  });
                },
                child: Text(
                  "Send",
                  style: TextStyle(color: Palette().bluebg),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
