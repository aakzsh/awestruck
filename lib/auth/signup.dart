import 'dart:convert';
import 'dart:io';

import 'package:awestruck/constant_widgets/bottom_nav.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  File _image;
  String _image1 = "";
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = pickedFile.path;
        _image = File(pickedFile.path);
        print(json.encode(_image1));
        print("file path...");
      } else {
        print('No image selected.');
      }
    });
  }

  String err = "";
  String _email, _pass, _pass2, username;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromRGBO(2, 10, 29, 1),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Text("Create an account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30))),
                  Container(
                    child: _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(
                              _image,
                            ))
                        : CircleAvatar(
                            radius: 50, backgroundColor: Palette().auroraGreen),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text("Select Image"),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("username")),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(
                        20,
                      ),
                      child: TextField(
                        onChanged: (namee) {
                          username = namee;
                        },
                        decoration: InputDecoration.collapsed(hintText: ""),
                      ),
                    ),
                    height: 50,
                    width: w - 40,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("email")),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: TextField(
                        onChanged: (emaill) {
                          _email = emaill;
                        },
                        // obscureText: true,
                        decoration: InputDecoration.collapsed(hintText: ""),
                      ),
                    ),
                    height: 50,
                    width: w - 40,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("password")),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: TextField(
                        onChanged: (namee) {
                          _pass = namee;
                        },
                        obscureText: true,
                        decoration: InputDecoration.collapsed(hintText: ""),
                      ),
                    ),
                    height: 50,
                    width: w - 40,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("confirm password")),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: TextField(
                        onChanged: (namee) {
                          _pass2 = namee;
                        },
                        obscureText: true,
                        decoration: InputDecoration.collapsed(hintText: ""),
                      ),
                    ),
                    height: 50,
                    width: w - 40,
                    color: Colors.blue.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                      minWidth: w - 40,
                      onPressed: () async {
                        var bytes = File(_image.path).readAsBytesSync();
                        String base64Image = base64Encode(bytes);
                        if (_pass == _pass2) {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _pass)
                              .then((value) {
                            if (value.user != null) {
                              FirebaseFirestore.instance
                                  .collection("userids")
                                  .doc(value.user.uid)
                                  .set({
                                "username": username,
                              }).then((value) => {
                                        FirebaseFirestore.instance
                                            .collection("friends")
                                            .doc(username)
                                            .set(
                                                {"friends": [], "pending": []}),
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(username)
                                            .set({
                                          "level": 1,
                                          "dob": "2000-01-01 00:00:00",
                                          "name": username,
                                          "steps_total": 0,
                                          "email": _email,
                                          "weekly_steps": [0, 0, 0, 0, 0, 0, 0],
                                          "status": "panda in the making",
                                          "meditation": 0,
                                          "pfp": base64Image.toString(),
                                          // "pfp": _image.readAsString(),
                                          "prevDay": DateTime.now().toString(),
                                          "place": {"lat": 40, "lng": 83},
                                          "totalCoins": 0,
                                          "totalStepsUntilYesterday": 0,
                                          "usedCoins": 0,
                                          "last_played": [
                                            "Meditation",
                                            "https://github.com/aakzsh/awestruck-library/blob/main/meditation/flute.mp3?raw=true"
                                          ]
                                        }).then((_) => {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomNav(),
                                                      ))
                                                })
                                      });
                            }
                          }).catchError((err) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(err.message),
                                    actions: [
                                      TextButton(
                                        child: Text("okay"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          });
                        } else {
                          setState(() {
                            err = "Passwords don't match!!";
                          });
                        }
                      },
                      child: Text(
                        "Create an account",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Color.fromRGBO(3, 202, 164, 1)),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already have an account yet? Log In",
                        style: TextStyle(color: Colors.blueGrey),
                      )),
                  Text(err),
                  SizedBox(height: 40)
                ],
              ),
            )));
  }
}
