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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double fh = 0.3 * h;
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
                    "Good Morning",
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
                                "600",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
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
                                "00:20",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
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
  }
}
