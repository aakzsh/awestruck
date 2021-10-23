import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                    MaterialButton(
                      minWidth: 120,
                      onPressed: () {},
                      color: Palette().auroraGreen,
                      child: Text("Edit Profile"),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(radius: 50),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Sara Jones"),
                      Text("@sarajones"),
                      Text("stars shine and so do i"),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    //add 3 widgets here
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                )
              ],
            )),
      ),
    );
  }
}
