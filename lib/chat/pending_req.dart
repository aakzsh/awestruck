// import 'package:awestruck/chat/chat.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:flutter/material.dart';

class PendingReq extends StatefulWidget {
  @override
  _PendingReqState createState() => _PendingReqState();
}

class _PendingReqState extends State<PendingReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette().bluebg,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Palette().bluebg,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Pending Requests",
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  friendReqTile("Amanda", "meditating"),
                  friendReqTile("frooti", "being a queen"),
                  friendReqTile("aakash", "being frooti ka friemd")
                ],
              ),
            ),
          ),
        ));
  }
}

friendReqTile(name, status) {
  return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
          status,
          style: TextStyle(fontSize: 11, color: Colors.white54),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle)),
              IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
            ],
          ),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
        ),
      ));
}
