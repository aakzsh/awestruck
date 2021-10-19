import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class StarRoom extends StatefulWidget {
  @override
  _StarRoomState createState() => _StarRoomState();
}

class _StarRoomState extends State<StarRoom> {
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
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("StarGaze",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Watch",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text(" the stars ",
                        style: TextStyle(
                          color: Color.fromRGBO(205, 143, 170, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Text("along",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
                Text("with your favorite people",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color.fromRGBO(3, 202, 164, 1),
                    onPressed: () {},
                    child: ListTile(
                      title: Text(
                        "Create a New Room",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Palette().bluebg),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    )),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue.withOpacity(0.2),
                    onPressed: () {},
                    child: ListTile(
                      title: Text(
                        "Join an Existing Room",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(3, 202, 164, 1)),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    )),
              ],
            ),
          )),
    );
  }
}
