// import 'package:awestruck/chat/chat.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awestruck/home.dart' as h;

class PendingReq extends StatefulWidget {
  @override
  _PendingReqState createState() => _PendingReqState();
}

class _PendingReqState extends State<PendingReq> {
  List pendingList = [];
  List friendList = [];
  void getPending() {
    FirebaseFirestore.instance
        .collection('friends')
        .doc(h.username)
        .get()
        .then((value) {
      setState(() {
        pendingList = value.data()['pending'];
        friendList = value.data()['friends'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getPending();
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: pendingList.length,
                      itemBuilder: (context, index) {
                        return friendReqTile(pendingList[index]);
                      })
                  // friendReqTile("Amanda", "meditating"),
                ],
              ),
            ),
          ),
        ));
  }

  friendReqTile(name) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: ListTile(
          title: Text(name),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      pendingList.remove(name);
                      setState(() {
                        pendingList = pendingList;
                      });

                      FirebaseFirestore.instance
                          .collection('friends')
                          .doc(h.username)
                          .set({"friends": friendList, "pending": pendingList});
                    },
                    icon: Icon(Icons.remove_circle)),
                IconButton(
                    onPressed: () {
                      pendingList.remove(name);
                      friendList.add(name);
                      setState(() {
                        pendingList = pendingList;
                        friendList = friendList;
                      });

                      FirebaseFirestore.instance
                          .collection('friends')
                          .doc(h.username)
                          .set({"friends": friendList, "pending": pendingList});
                      FirebaseFirestore.instance
                          .collection('friends')
                          .doc(name)
                          .get()
                          .then((value) {
                        List pl = [];
                        List fl = [];
                        pl = value.data()['pending'];
                        fl = value.data()['friend'];
                        if (fl == null) {
                          fl = [h.username];
                        } else {
                          fl.add(h.username);
                        }
                        print(fl);
                        FirebaseFirestore.instance
                            .collection('friends')
                            .doc(name)
                            .set({
                          'pending': pl,
                          'friends': fl,
                        });
                      });
                    },
                    icon: Icon(Icons.add_circle)),
              ],
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
          ),
        ));
  }
}
