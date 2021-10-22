import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class Gaze extends StatefulWidget {
  const Gaze({Key key}) : super(key: key);

  @override
  _GazeState createState() => _GazeState();
}

class _GazeState extends State<Gaze> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        Container(
            height: h,
            width: w,
            child: Panorama(
              child: Image.asset('images/starmap.png'),
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
                    Text("Room: fmlfml",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        )),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ListTile(
                      leading: Text("Currently Viewing\nKolkata, India"),
                      title: SizedBox(),
                      trailing: Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.location_city,
                                    color: Colors.pink)),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    Icon(Icons.music_note, color: Colors.blue)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.message,
                                    color: Colors.greenAccent))
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.pinkAccent,
                        radius: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        radius: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        radius: 20,
                      ),
                    ],
                  )
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