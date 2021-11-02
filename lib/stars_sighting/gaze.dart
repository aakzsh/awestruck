import 'dart:convert';
import 'package:awestruck/constant_widgets/img_string.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:awestruck/stars_sighting/join_room.dart';
import 'package:awestruck/webview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:awestruck/stars_sighting/byte_image.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
import 'package:geocoder/geocoder.dart';

class Gaze extends StatefulWidget {
  // const Gaze({Key key}) : super(key: key);

  @override
  _GazeState createState() => _GazeState();
}

var addresses, first;
double lat = 28.5355;
double lng = 77.3910;
double latshow = 28.5355, lngshow = 77.3910;
final coordinates = new Coordinates(latshow, lngshow);
String yourCity = "city";
var address;

class _GazeState extends State<Gaze> {
  bool _visible = true;
  Gaze gr;
  // final coordinates = new Coordinates(19.0760, 72.8777);

// print("${first.featureName} : ${first.addressLine}");

  _fetchImage() async {
    FirebaseFirestore.instance
        .collection("room")
        .doc(UniversalCode.toString())
        .get()
        .then((value) => {
              setState(() {
                url = value.data()['url'];
                latshow = value.data()['lat'];
                lngshow = value.data()['lng'];
              })
            });
  }

  fetchcity() async {
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    setState(() {
      yourCity = first.addressLine.toString();
    });
  }

  String gaze = "HEHEHE";
  // String url =
  //     "https://media.discordapp.net/attachments/873911460055642152/900611477306765362/10.png";

  @override
  Widget build(BuildContext context) {
    var addresses = Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print(gr.code);
    _fetchImage();
    fetchcity();
    // var c = _fetchcity();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(25, 29, 41, 1),
            child: Stack(
              children: <Widget>[
                Container(
                    color: Color.fromRGBO(25, 29, 41, 1),
                    height: h,
                    width: w,
                    child: Panorama(
                      child: Image.memory(base64Decode(url)),
                      // child: Image.network(url),
                      sensorControl: SensorControl.Orientation,
                      animSpeed: 0.1,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Room: $UniversalCode",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
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
                      color: Palette().bluebg,
                      width: w,
                      height: 100,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                              leading:
                                  Text("Currently Viewing\n" + city(yourCity)),
                              title: SizedBox(),
                              trailing: Container(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          side:
                                              BorderSide(color: Colors.yellow),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      minWidth: w / 2 - 40,
                                      color: Colors.yellow,
                                      child: Text(
                                        "Share on Snapchat",
                                        style:
                                            TextStyle(color: Palette().bluebg),
                                      ),
                                      onPressed: () async {
                                        String url =
                                            'https://nightsky-api.herokuapp.com/share_starmap/$UniversalCode';

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Webview(url)));
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      color: Palette().bluebg,
                      width: w,
                      height: 150,
                    ),
                  ],
                )
              ],
            )));
  }
}

city(String yourCity) {
  if (yourCity.length > 20) {
    List<String> dummy = yourCity.split(",");
    int len = dummy.length;
    return dummy[len - 3] + "," + dummy[len - 2] + "," + dummy[len - 1];
    // return;
  } else {
    return yourCity;
  }
}
