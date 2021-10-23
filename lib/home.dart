import 'package:awestruck/auth/login.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Image.asset("images/")
                SizedBox(
                  height: 2,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Today's Stats")),
                    Container(
                      height: 100,
                      color: Colors.green,
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
