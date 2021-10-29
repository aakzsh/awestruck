import 'package:awestruck/chat/messaging.dart';
import 'package:awestruck/chat/pending_req.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/home.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awestruck/chat/friend.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String newFriend;
  List<Friend> _friends = <Friend>[];
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() {
    print(username);
    FirebaseFirestore.instance
        .collection('friends')
        .doc(username)
        .get()
        .then((value) {
      List friendList = value.data()['friends'];

      for (var friend in friendList) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(friend)
            .get()
            .then((value) {
          print(value.data());
          if (!_friends.contains(Friend(friend, value.data()['status']))) {
            setState(() {
              _friends.add(Friend(friend, value.data()['status']));
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // getInfo();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Palette().bluebg,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Chat",
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    minWidth: w / 2 - 40,
                    // color: Colors.red,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Palette().auroraGreen),
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingReq()));
                    },
                    child: Text(
                      "Pending Requests",
                      style: TextStyle(color: Palette().auroraGreen),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Palette().auroraGreen),
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: w / 2 - 40,
                    color: Palette().auroraGreen,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Palette().bluebg,
                              title: Text("Find by username"),
                              content: Container(
                                // color: Palette().bluebg.withOpacity(0.8),
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      onChanged: (value2) {
                                        newFriend = value2;
                                      },
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                MaterialButton(
                                  color: Palette().auroraGreen,
                                  child: Text(
                                    "Next",
                                    style: TextStyle(color: Palette().bluebg),
                                  ),
                                  onPressed: () async {},
                                )
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Add Friends",
                      style: TextStyle(color: Palette().bluebg),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Friends",
                    style: TextStyle(fontSize: 30, color: Colors.white54),
                  ),
                ),
              ),
              // InkWell(
              //   child: friendTile("Amanda", "meditating"),
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => Messaging()));
              //   },
              // ),
              // friendTile("frooti", "being a queen"),
              // friendTile("aakash", "being frooti ka friemd")
              ListView.builder(
                  itemCount: _friends.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return friendTile(
                        _friends[index].name, _friends[index].status, context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

friendTile(name, status, context) {
  String roomId;
  List people = [name, username];
  people.sort();

  roomId = people[0] + "_" + people[1];
  print("$roomId in chat");
  return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
          status,
          style: TextStyle(fontSize: 11, color: Colors.white54),
        ),
        leading: CircleAvatar(
          backgroundColor: Palette().auroraGreen,
          radius: 20,
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) => Messaging(roomId, status, name),
            settings: RouteSettings(
                // arguments: {roomId: roomId, status: status},
                ),
          ));
        },
      ));
}
