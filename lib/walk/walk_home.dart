import 'package:awestruck/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:awestruck/constant_widgets/palette.dart';

class WalkHome extends StatefulWidget {
  @override
  _WalkHomeState createState() => _WalkHomeState();
}

class _WalkHomeState extends State<WalkHome> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double cont_w = (w - 40) / 3 - 15;
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Palette().bluebg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Steps Tracker",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                      )
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 200.0,
                  lineWidth: 13.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: 0.9,
                  animateFromLastPercent: true,
                  center: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Total Steps",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "698",
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xff03CAA4),
                  backgroundColor: Color(0xff222D48),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff151D31),
                          borderRadius: BorderRadius.circular(10)),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                )
              ],
            ),
          )),
    );
  }
}
