import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/meditation/play.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  @override
  _MeditationState createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double cont = (w - 40) / 3 - 15;
    return Scaffold(
        backgroundColor: Palette().bluebg,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Palette().bluebg,
              child: SingleChildScrollView(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
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
                          title: Text("Meditation"),
                          subtitle: Text("06:00 left"),
                          leading: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.play_arrow,
                                  size: 30,
                                  color: Color.fromRGBO(253, 204, 250, 1))),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Meditaion",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/meditation/flute.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Flute",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Yoga",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          )),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(9, 70, 79, 1),
                              Color.fromRGBO(107, 228, 255, 1)),
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(9, 70, 79, 1),
                              Color.fromRGBO(107, 228, 255, 1)),
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(9, 70, 79, 1),
                              Color.fromRGBO(107, 228, 255, 1)),
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(9, 70, 79, 1),
                              Color.fromRGBO(107, 228, 255, 1)),
                          listContainer(
                            cont,
                            "Relax",
                            Color.fromRGBO(9, 70, 79, 1),
                            Color.fromRGBO(107, 228, 255, 1),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Nature sounds",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(20, 100, 65, 1),
                              Palette().auroraGreen),
                          listContainer(
                              cont,
                              "Calm",
                              Color.fromRGBO(20, 100, 65, 1),
                              Palette().auroraGreen),
                          listContainer(
                              cont,
                              "Soothe",
                              Color.fromRGBO(20, 100, 65, 1),
                              Palette().auroraGreen),
                          listContainer(
                              cont,
                              "Relax",
                              Color.fromRGBO(20, 100, 65, 1),
                              Palette().auroraGreen),
                          listContainer(
                              cont,
                              "Calm",
                              Color.fromRGBO(20, 100, 65, 1),
                              Palette().auroraGreen),
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
        ));
  }
}

listContainer(cont, name, txtcolor, clr) {
  return Padding(
    padding: EdgeInsets.only(right: 10),
    child: Container(
      child: Center(
        child: Text(name,
            style: TextStyle(
                color: txtcolor, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      height: cont,
      width: cont,
      color: clr,
    ),
  );
}
