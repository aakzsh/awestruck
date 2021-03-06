import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:awestruck/stars_sighting/gaze.dart';
import 'package:awestruck/stars_sighting/join_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

// String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

List<Map> participantshehe = [{}, {}];
int nums;

class _CreateRoomState extends State<CreateRoom> {
  CreateRoom cr;
  String name = "", status = "", username = "";
  var r = Random();

  getData() async {
    await FirebaseFirestore.instance
        .collection("room")
        .doc(UniversalCode)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  print("exists"),
                  setState(() {
                    participantshehe = value.data()['participants'];
                  })
                }
              else
                {print("doesnt exist")}
            });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    getData();
    // double cont_w = (w - 40) / 3 - 15;
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Palette().bluebg,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: h - 60,
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Create New Room",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    )),
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: MemoryImage(lmaoo),
                                    // backgroundColor: Colors.white,
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
                                awayAnimationDuration:
                                    Duration(milliseconds: 1000),
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
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Copy room ID to invite friends",
                                style: TextStyle(color: Colors.white54),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            color:
                                Color.fromRGBO(21, 29, 49, 1).withOpacity(0.9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        UniversalCode,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white54),
                                      )),
                                  width: w - 90,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                              text: UniversalCode))
                                          .then((value) => {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Code Copied!"))),
                                              });
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: Palette().auroraGreen,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     "People in the room",
                          //     style: TextStyle(color: Colors.white54),
                          //   ),
                          // ),
                          // Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text("There are llll people in the room!"))
                          // Container(
                          //   height: 200,
                          //   child: ListView.builder(
                          //       itemCount: participantshehe.length,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return participantList(
                          //             participantshehe[index]['name'],
                          //             participantshehe[index]['status']);
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color.fromRGBO(3, 202, 164, 1),
                          onPressed: () {
                            setState(() {
                              lat = lat;
                              lng = lat;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gaze()));
                          },
                          child: ListTile(
                              title: Center(
                            child: Text(
                              "Start Star Gazing",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Palette().bluebg),
                            ),
                          ))),
                      // SizedBox(
                      //   height: 100,
                      // ),
                      Container(
                        height: 100,
                        child: WebView(
                          debuggingEnabled: true,
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl:
                              "https://nightsky-api.herokuapp.com/night?code=$UniversalCode&&lat=${lat.toString()}&&lng=${lng.toString()}&&time=now",
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}

participantList(name, status) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
          status,
          style: TextStyle(color: Colors.white54),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_circle,
              color: Colors.redAccent,
            )),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
      ));
}
