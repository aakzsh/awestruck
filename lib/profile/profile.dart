import 'dart:convert';
import 'dart:typed_data';

import 'package:awestruck/auth/login.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:awestruck/home.dart';
import 'package:awestruck/chat/chat.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

String pfpurl = "";

Uint8List lmaoo = base64Decode(pfpurl);

class _ProfileState extends State<Profile> {
  DateTime selectedDate = DateTime.parse("2000-01-01 00:00:00");
  String stringParse = "2000-01-01-00:00:00";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        stringParse = selectedDate.toString().split(' ')[0] +
            "-" +
            selectedDate.toString().split(' ')[1];
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(username)
          .update({'dob': selectedDate.toString()});
    }
  }

  String newname, newstatus;
  String name = "name",
      status = "status",
      username = "username",
      dob = "2000-01-01 00:00:00",
      dobstr = "Jan 1, 2000";

  List<String> starsign =
      getZodiacSign(DateTime.now().day, DateTime.now().month);

  int level = 1;
  List<Map> friendList = [
    {'name': 'name'}
  ];

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
                          // pfp = value.data()['pfp'];
                          name = value.data()['name'];
                          status = value.data()['status'];
                          // pfpurl = status = value.data()['pfp'];
                          dob = value.data()['dob'];
                          starsign = getZodiacSign(DateTime.parse(dob).day,
                              DateTime.parse(dob).month);
                        })
                      })
            });
  }

  getFriends() {
    FirebaseFirestore.instance
        .collection('friends')
        .doc(username)
        .get()
        .then((value) => {
              setState(() {
                friendList = value.data()['friends'];
              }),
            });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    getData();
    getFriends();
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
                        Text("Profile",
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
                            backgroundImage: MemoryImage(lmaoo),
                            radius: 80,
                            // backgroundColor: Colors.amber,
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
                                    ((steps_total / 100).floor() + 1)
                                        .toString(),
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
                                  Text("Friends"),
                                  Text(
                                    friendList.length.toString(),
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Palette().auroraGreen,
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
                                  Text(
                                    starsign[1],
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(starsign[0])
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
                    Row(
                      children: <Widget>[
                        Text(
                            "Your Star Map [${DateTime.parse(dob).day}/${DateTime.parse(dob).month}/${DateTime.parse(dob).year}]"),
                        IconButton(
                            // iconSize: 100,
                            onPressed: () async {
                              print("hello");
                              await _selectDate(context);
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: WebView(
                        initialUrl:
                            "https://nightsky-api.herokuapp.com/night?code=general&&lat=28.5355&&lng=77.3910&&time=$stringParse",
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                      width: w - 40,
                      height: 200,
                      color: Colors.transparent,
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => App()),
                                          (route) => false);
                                });
                              },
                              icon: Icon(EvaIcons.logOut,
                                  color: Palette().auroraGreen),
                            ))),
                    SizedBox(
                      height: 80,
                    )
                  ],
                )),
          ),
        ));
  }
}

// pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => Login()),
//                                       (Route<dynamic> route) => false);

getZodiacSign(int day, int month) {
  if ((month == 1 && day <= 20) || (month == 12 && day >= 22)) {
    return ["capricorn", "♑"];
  } else if ((month == 1 && day >= 21) || (month == 2 && day <= 18)) {
    return ["aquarius", "♒"];
  } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
    return ["pisces", "♓"];
  } else if ((month == 3 && day >= 21) || (month == 4 && day <= 20)) {
    return ["aries", "♈"];
  } else if ((month == 4 && day >= 21) || (month == 5 && day <= 20)) {
    return ["taurus", "♉"];
  } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
    return ["gemini", "♊"];
  } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
    return ["cancer", "♋"];
  } else if ((month == 7 && day >= 23) || (month == 8 && day <= 23)) {
    return ["leo", "♌"];
  } else if ((month == 8 && day >= 24) || (month == 9 && day <= 23)) {
    return ["virgo", "♍"];
  } else if ((month == 9 && day >= 24) || (month == 10 && day <= 23)) {
    return ["libra", "♎"];
  } else if ((month == 10 && day >= 24) || (month == 11 && day <= 22)) {
    return ["scorpio", "♏"];
  } else if ((month == 11 && day >= 23) || (month == 12 && day <= 21)) {
    return ["sagittarius", "♐"];
  } else {
    return ["unknown", "♐"];
  }
}
