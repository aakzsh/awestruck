import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String newname, newstatus;
  String name = "name", status = "status", username = "username";
  getData() {
    FirebaseFirestore.instance
        .collection('userids')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
              setState(() {
                username = value.data()['username'];
              }),
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(value.data()['username'])
                  .get()
                  .then((value) => {
                        setState(() {
                          name = value.data()['name'];
                          status = value.data()['status'];
                        })
                      })
            });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    getData();
    return Scaffold(
        backgroundColor: Palette().bluebg,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Palette().bluebg,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Meditation",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                        MaterialButton(
                          minWidth: 120,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Edit Details"),
                                    content: Container(
                                      // color: Palette().bluebg.withOpacity(0.8),
                                      height: 150,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("name"),
                                          TextFormField(
                                            initialValue: name,
                                            onChanged: (value) {
                                              newname = value;
                                            },
                                          ),
                                          Text("status"),
                                          TextFormField(
                                            initialValue: status,
                                            onChanged: (value2) {
                                              newstatus = value2;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Edit Changes"),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(username)
                                              .update({
                                            'name': newname,
                                            'status': newstatus,
                                          }).then((_) =>
                                                  Navigator.pop(context));
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          color: Palette().auroraGreen,
                          child: Text("Edit Profile"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            username,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.white54),
                          ),
                          Text("~ " + status + " |"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //add 3 widgets here
                        Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Level"),
                                  Text(
                                    "7",
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 130,
                              width: w / 4,
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Status"),
                                  Icon(
                                    Icons.online_prediction,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 130,
                              width: w / 4,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text("Star Sign"),
                                  Icon(Icons.star, color: Colors.greenAccent),
                                  Text("Aquarius")
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 130,
                              width: w / 4,
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your Star Map"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w - 40,
                      height: 200,
                      color: Colors.blue.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: IconButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut().then((res) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => App()),
                                      (Route<dynamic> route) => false);
                                });
                              },
                              icon: Icon(EvaIcons.logOut,
                                  color: Palette().auroraGreen),
                            )))
                  ],
                )),
          ),
        ));
  }
}
