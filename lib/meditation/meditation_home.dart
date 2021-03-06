import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/home.dart';
import 'package:awestruck/meditation/play.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  @override
  _MeditationState createState() => _MeditationState();
}

uploadLastPlayed(x, y) {
  FirebaseFirestore.instance.collection("users").doc(username).update({
    "last_played": [x, y]
  });
}

List lp = [
  "Meditation",
  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/flute.mp3?raw=true"
];

class _MeditationState extends State<Meditation> {
  getLastPlayed() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .get()
        .then((value) => {
              setState(() {
                lp = value.data()['last_played'];
              })
            });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getLastPlayed());
    // getLastPlayed();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double cont = (w - 40) / 3 - 15;
    getLastPlayed();
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
                          title: Text(lp[0]),
                          subtitle: Text("continue"),
                          leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  form = lp[0];
                                  musicUrl = lp[1];
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Play()));
                              },
                              icon: Icon(Icons.play_arrow,
                                  size: 30,
                                  color: Color.fromRGBO(253, 204, 250, 1))),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Meditation",
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
                              uploadLastPlayed("Meditation",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/flute.mp3?raw=true");
                              setState(() {
                                form = "Meditation";
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
                              uploadLastPlayed("Meditation",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Calm.mp3?raw=true");
                              setState(() {
                                form = "Meditation";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Calm.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(9, 70, 79, 1),
                                Color.fromRGBO(107, 228, 255, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Meditation",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Peace.mp3?raw=true");
                              setState(() {
                                form = "Meditation";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Peace.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Peace",
                                Color.fromRGBO(20, 100, 65, 1),
                                Palette().auroraGreen),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Meditation",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Relax.mp3?raw=true");
                              setState(() {
                                form = "Meditation";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Relax.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Relax",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Meditation",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Soothe.mp3?raw=true");
                              setState(() {
                                form = "Meditation";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/meditation/Soothe.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Soothe",
                                Color.fromRGBO(9, 70, 79, 1),
                                Color.fromRGBO(107, 228, 255, 1)),
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
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Yoga",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/yoga/calm.mp3?raw=true");
                              setState(() {
                                form = "Yoga";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/yoga/calm.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Calm",
                                Color.fromRGBO(20, 100, 65, 1),
                                Palette().auroraGreen),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Yoga",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/yoga/breathe.mp3?raw=true");
                              setState(() {
                                form = "Yoga";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/yoga/breathe.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Breathe",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Yoga",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/yoga/chant.mp3?raw=true");
                              setState(() {
                                form = "Yoga";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/yoga/chant.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Chant",
                                Color.fromRGBO(9, 70, 79, 1),
                                Color.fromRGBO(107, 228, 255, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Yoga",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/yoga/fast.mp3?raw=true");
                              setState(() {
                                form = "Yoga";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/yoga/fast.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Fast",
                                Color.fromRGBO(20, 100, 65, 1),
                                Palette().auroraGreen),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Yoga",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/yoga/power.mp3?raw=true");
                              setState(() {
                                form = "Yoga";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/yoga/power.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Power",
                                Color.fromRGBO(152, 91, 189, 1),
                                Color.fromRGBO(233, 200, 253, 1)),
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
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Natural Sounds",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/rain.mp3?raw=true");
                              setState(() {
                                form = "Natural Sounds";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/rain.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Rain",
                                Color.fromRGBO(9, 70, 79, 1),
                                Color.fromRGBO(107, 228, 255, 1)),
                          ),
                          InkWell(
                              onTap: () {
                                uploadLastPlayed("Natural Sounds",
                                    "https://github.com/aakzsh/awestruck-library/blob/main/jungle.mp3?raw=true");
                                setState(() {
                                  form = "Natural Sounds";
                                  musicUrl =
                                      "https://github.com/aakzsh/awestruck-library/blob/main/jungle.mp3?raw=true";
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Play()));
                              },
                              child: listContainer(
                                  cont,
                                  "Jungle",
                                  Color.fromRGBO(20, 100, 65, 1),
                                  Palette().auroraGreen)),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Natural Sounds",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/space.mp3?raw=true");
                              setState(() {
                                form = "Natural Sounds";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/space.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                              cont,
                              "Space",
                              Color.fromRGBO(152, 91, 189, 1),
                              Color.fromRGBO(233, 200, 253, 1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Natural Sounds",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/wind.mp3?raw=true");
                              setState(() {
                                form = "Natural Sounds";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/wind.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Wind",
                                Color.fromRGBO(9, 70, 79, 1),
                                Color.fromRGBO(107, 228, 255, 1)),
                          ),
                          InkWell(
                            onTap: () {
                              uploadLastPlayed("Natural Sounds",
                                  "https://github.com/aakzsh/awestruck-library/blob/main/birds.mp3?raw=true");
                              setState(() {
                                form = "Natural Sounds";
                                musicUrl =
                                    "https://github.com/aakzsh/awestruck-library/blob/main/birds.mp3?raw=true";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Play()));
                            },
                            child: listContainer(
                                cont,
                                "Birds",
                                Color.fromRGBO(20, 100, 65, 1),
                                Palette().auroraGreen),
                          )
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
