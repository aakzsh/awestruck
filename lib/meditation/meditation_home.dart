import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:awestruck/stars_sighting/star_home.dart';
import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  @override
  _MeditationState createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double cont_w = (w - 40) / 3 - 15;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Palette().bluebg,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Meditation",
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pick up where you left",
                    style: TextStyle(color: Colors.white54),
                  )),
              SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(3, 202, 164, 1),
                        Color.fromRGBO(2, 83, 149, 1)
                      ]),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text("Dream With Me"),
                    subtitle: Text("06:00 left"),
                    leading: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.play_arrow,
                            size: 30, color: Color.fromRGBO(253, 204, 250, 1))),
                  )),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Guided Meditation",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text("Calm",
                          style: TextStyle(
                              color: Color.fromRGBO(9, 70, 79, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Color.fromRGBO(107, 228, 255, 1),
                  ),
                  Container(
                    child: Center(
                      child: Text("Relax",
                          style: TextStyle(
                              color: Color.fromRGBO(152, 91, 189, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Color.fromRGBO(233, 200, 253, 1),
                  ),
                  Container(
                    child: Center(
                      child: Text("Soothe",
                          style: TextStyle(
                              color: Color.fromRGBO(20, 100, 65, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Palette().auroraGreen,
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Unguided Meditation",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    )),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text("Soothe",
                          style: TextStyle(
                              color: Color.fromRGBO(20, 100, 65, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Palette().auroraGreen,
                  ),
                  Container(
                    child: Center(
                      child: Text("Calm",
                          style: TextStyle(
                              color: Color.fromRGBO(9, 70, 79, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Color.fromRGBO(107, 228, 255, 1),
                  ),
                  Container(
                    child: Center(
                      child: Text("Relax",
                          style: TextStyle(
                              color: Color.fromRGBO(9, 70, 79, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    height: cont_w,
                    width: cont_w,
                    color: Color.fromRGBO(107, 228, 255, 1),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Customise",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                height: 20,
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter a valid youtube URL"),
                          ),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Palette().auroraGreen,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              // MaterialButton(
              //     child: Text(
              //       "go to star home",
              //     ),
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => StarRoom()));
              //     })
            ],
          ),
        )),
      ),
    );
  }
}
