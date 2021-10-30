import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:awestruck/stars_sighting/gaze.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

String UniversalCode;

class _JoinRoomState extends State<JoinRoom> {
  String code = "";
  String txt = "";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // double cont_w = (w - 40) / 3 - 15;
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
                      Text("Join Room",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.deepPurple.withOpacity(0.2),
                  ),
                  key: UniqueKey(),
                  child: Center(
                    child: CircularParticle(
                      // key: UniqueKey(),
                      awayRadius: 1500,
                      numberOfParticles: 30,
                      speedOfParticles: 0.5,
                      height: 150,
                      width: 150,
                      onTapAnimation: false,
                      particleColor: Colors.white.withAlpha(150),
                      awayAnimationDuration: Duration(milliseconds: 1000),
                      maxParticleSize: 0.8,
                      isRandSize: true,
                      isRandomColor: false,

                      awayAnimationCurve: Curves.easeInOutBack,
                      enableHover: false,
                      hoverColor: Colors.white,
                      hoverRadius: 90,
                      connectDots: true,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Enter Room ID",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          )),
                    ),
                    Container(
                      color: Color.fromRGBO(21, 29, 49, 1).withOpacity(0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: w - 90,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  onChanged: (value) {
                                    code = value;
                                    UniversalCode = value;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none, hintText: ""),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color.fromRGBO(3, 202, 164, 1),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("room")
                          .doc(code)
                          .get()
                          .then((value) => {
                                if (value.exists)
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Gaze()))
                                  }
                                else
                                  {
                                    setState(() {
                                      txt = "Code Doesn't Exist";
                                    })
                                  }
                              });
                    },
                    child: ListTile(
                        title: Center(
                      child: Text(
                        "Join Room",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Palette().bluebg),
                      ),
                    ))),
                SizedBox(
                  height: 5,
                ),
                Text(txt),
              ],
            ),
          )),
    );
  }
}
