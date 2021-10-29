import 'dart:convert';

import 'package:awestruck/chat/messaging.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class NewAurora extends StatefulWidget {
  const NewAurora({Key key}) : super(key: key);

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewAuroraSend()));
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
  @override
  _NewAuroraSendState createState() => _NewAuroraSendState();
}

class _NewAuroraSendState extends State<NewAuroraSend> {
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
