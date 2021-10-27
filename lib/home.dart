import 'package:awestruck/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:after_layout/after_layout.dart';

//firebase vars
String email, name, status, username;
String prevDay, dob;
int meditation, steps_total, totalStepsUntilYesterday, totalCoins, usedCoins;
Map place;
List weekly_steps;
Stream documentStream;

class Decide extends StatefulWidget {
  // const Decide({Key? key}) : super(key: key);

  @override
  _DecideState createState() => _DecideState();
}

class _DecideState extends State<Decide> {
  bool isLogged = false;
  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      return Home();
    } else {
      return Login();
    }
  }
}

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greeting = "Morning";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchData());
    fetchData();
  }

  //get data from firebase
  void fetchData() {
    FirebaseFirestore.instance
        .collection('userids')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
              setState(() {
                username = value.data()['username'];
              }),
              documentStream = FirebaseFirestore.instance
                  .collection('users')
                  .doc(value.data()['username'])
                  .snapshots(),
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(value.data()['username'])
                  .get()
                  .then((value) => {
                        setState(() {
                          name = value.data()['name'];
                          status = value.data()['status'];
                          email = value.data()['email'];
                          dob = value.data()['dob'];
                          meditation = value.data()['meditation'];
                          prevDay = value.data()['prevDay'];
                          steps_total = value.data()['steps_total'];
                          totalCoins = value.data()['totalCoins'];
                          totalStepsUntilYesterday =
                              value.data()['totalStepsUntilYesterday'];
                          usedCoins = value.data()['usedCoins'];
                          weekly_steps = value.data()['weekly_steps'];
                        })
                      })
                  .then((value) {
                print(weekly_steps);
              })
            });
  }

  var now = DateTime.now();
  findGreeting(int x) {
    if (x > 3 && x < 12) {
      setState(() {
        greeting = "Morning";
      });
    } else if (x >= 12 && x < 16) {
      setState(() {
        greeting = "Afternoon";
      });
    } else if (x >= 16 && x < 21) {
      setState(() {
        greeting = "Evening";
      });
    } else {
      setState(() {
        greeting = "Night";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    findGreeting(now.hour);
    // fetchData();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double fh = 0.3 * h;
    return StreamBuilder(
        stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/home.png'), fit: BoxFit.cover),
              ),
              width: w,
              height: h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: w - 90,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
                        child: Text(
                          "Good $greeting",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: fh,
                      ),
                      SizedBox(
                        child: Container(
                          width: w - 90,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Text(
                              "Today's Stats",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: w - 92,
                        decoration: BoxDecoration(
                            color: Color(0xff101B38),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text(
                                      "Steps",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data['steps_total'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32),
                                    )
                                  ],
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                  color: Color(0xFFF6F4F4),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Meditation",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data['meditation'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              ),
            ),
          );
        });
  }
}
