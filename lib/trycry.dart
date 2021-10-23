import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TryCry extends StatefulWidget {
  @override
  _TryCryState createState() => _TryCryState();
}

class _TryCryState extends State<TryCry> {
  String img_url = "pehle";
  getData() async {
    await FirebaseFirestore.instance
        .collection("room")
        .doc("665dcc1d-3647-44b7-8af8-f62a8413bc03")
        .get()
        .then((value) => {print(value.data())});
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getEmail() async {
      var a = await FirebaseFirestore.instance
          .collection("met_with")
          .doc('665dcc1d-3647-44b7-8af8-f62a8413bc03')
          .get();
      return a['email'];
    }

    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("hemloo"),
            FutureBuilder(
              future: getEmail(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                        // here only return is missing
                        child: Image.memory(
                            base64Decode(snapshot.data.toString())));
                  }
                } else if (snapshot.hasError) {
                  return Text('no data');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
