import 'dart:convert';
import 'dart:typed_data';

// import 'package:awestruck/auth/login.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:awestruck/home.dart' as h;

class PublicProfile extends StatefulWidget {
  PublicProfile(this.searchString);
  String searchString;
  @override
  _PublicProfileState createState() => _PublicProfileState();
}

String pfpurl_public = "";
// Uint8List lmaoo;

class _PublicProfileState extends State<PublicProfile> {
  String newname, newstatus;
  String name = "name",
      status = "status",
      username = "username",
      dob = "2000-01-01 00:00:00",
      dobstr = "Jan 1, 2000",
      stringParse = "";
  int level;
  List friendList = [];
  List pendingList = [];
  List<String> starsign;
  getData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.searchString)
        .get()
        .then((value) => {
              setState(() {
                // pfp = value.data()['pfp'];
                name = value.data()['name'];
                status = value.data()['status'];
                // pfpurl_public = value.data()['pfp'];
                dob = value.data()['dob'];
                level = value.data()['level'];
                starsign = getZodiacSign(
                    DateTime.parse(dob).day, DateTime.parse(dob).month);
                stringParse = dob.split(" ")[0] + "-" + dob.split(" ")[1];
              })
            });
  }

  getFriends() {
    FirebaseFirestore.instance
        .collection('friends')
        .doc(widget.searchString)
        .get()
        .then((value) => {
              setState(() {
                friendList = value.data()['friends'];
                pendingList = value.data()['pending'];
              }),
            });
  }

  Uint8List lmaooo = base64Decode(pfpurl_public);
  String buttonText = " bt";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    getData();
    getFriends();
    // print(h.friendList);
    if (h.friendList.contains(widget.searchString)) {
      buttonText = "Already a friend";
    } else if (pendingList.contains(h.username)) {
      buttonText = "Pending";
    } else {
      buttonText = "Add Friend";
    }
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
                        Text("Public Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: MemoryImage(lmaooo),
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
                      height: 20,
                    ),
                    MaterialButton(
                      disabledColor: Colors.grey,
                      color: Palette().auroraGreen,
                      onPressed: (buttonText == "Add Friend")
                          ? () {
                              print("progress hai");
                              pendingList.add(h.username);
                              print("pendingList, $username");
                              FirebaseFirestore.instance
                                  .collection('friends')
                                  .doc(widget.searchString)
                                  .set({
                                "friends": friendList,
                                "pending": pendingList
                              });
                            }
                          : null,
                      child: Text(buttonText),
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
                                    level.toString(),
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
