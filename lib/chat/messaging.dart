import 'package:awestruck/chat/decrypt.dart';
import 'package:awestruck/chat/msgData.dart';
import 'package:awestruck/chat/newAurora.dart';
import 'package:awestruck/constant_widgets/palette.dart';
import 'package:awestruck/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// imp
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gq;

class Messaging extends StatefulWidget {
  Messaging(this.roomId, this.status, this.name);
  String roomId;
  String name;
  String status;
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  DatabaseReference _messagesRef;
  DatabaseReference _firebaseRef = FirebaseDatabase(
          databaseURL:
              'https://awestruck-d86c7-default-rtdb.asia-southeast1.firebasedatabase.app')
      .reference();
  String h = "happy";
  String url1, url2;

  String getStickerString(String h) {
    String GET_STICKERS = ''' 
    
    query SearchStickerSample {
      sticker {
        searchStickers(
          req:{
            searchStickersParams:{searchText: "$h", numberResults: 2},
            stickerUserContext:{countryCode: US, localTimeZoneUTCOffsetMinutes: 2,locale: EN_US}
          }){
          stickerResults {
            items {
              itemType
              id
              pngURL
              thumbnailURL
            }
          }
        }
      }
    }
  ''';
    return GET_STICKERS;
  }

  sendSticker(_firebaseref, widget, context) {
    print("$h -----------------------------");

    final _stickertextcontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Palette().bluebg,
              content: Container(
                // color: Palette().bluebg.withOpacity(0.8),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: TextField(
                            controller: _stickertextcontroller,
                            decoration: InputDecoration.collapsed(
                                hintText: "Search Stickers"),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                print(
                                    "****************************** ${_stickertextcontroller.text}");
                                h = _stickertextcontroller.text;
                              });
                            },
                            icon: Icon(Icons.search))
                      ],
                    ),
                    gq.Query(
                      options: gq.QueryOptions(
                        document: gq.gql(getStickerString(h)),
                      ),
                      builder: (
                        gq.QueryResult result, {
                        VoidCallback refetch,
                        gq.FetchMore fetchMore,
                      }) {
                        print("query");
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }

                        if (result.isLoading) {
                          return Text('Loading');
                        }

                        List repositories = result.data['sticker']
                            ['searchStickers']['stickerResults']['items'];

                        print(
                            "${repositories[0]['pngURL']} ============================");

                        String url1 = repositories[0]['pngURL'] + ".png";
                        String url2 = repositories[1]['pngURL'] + ".png";

                        // return Text("hello");
                        // return Image.network(
                        //   url,
                        //   height: 10,
                        //   width: 10,
                        // );

                        return Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              child: Image.network(url1, height: 50),
                              onTap: () {
                                final msgData = MsgData(
                                    author: username,
                                    message_body: null,
                                    time: DateTime.now().toString(),
                                    aurora: false,
                                    sticker: url1);
                                _firebaseref
                                    .child(widget.roomId)
                                    .push()
                                    .set(msgData.toMap())
                                    .then((value) {});
                              },
                            ),
                            InkWell(
                              child: Image.network(url2, height: 50),
                              onTap: () {
                                final msgData = MsgData(
                                    author: username,
                                    message_body: null,
                                    time: DateTime.now().toString(),
                                    aurora: false,
                                    sticker: url2);
                                _firebaseref
                                    .child(widget.roomId)
                                    .push()
                                    .set(msgData.toMap())
                                    .then((value) {});
                              },
                            ),
                          ],
                        ));
                      },
                    )
                  ],
                ),
              ),
              actions: [],
            );
          });
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final roomId = ModalRoute.of(context).settings.arguments;
    Stream _messagesStream = _firebaseRef
        .child(widget.roomId)
        .orderByChild('time')
        .limitToLast(50)
        .onValue;
    print(widget.roomId);
    final _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 450),
          curve: Curves.fastOutSlowIn,
        );
      }
    });

    // getUser(roomId);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final messageController = TextEditingController();
    return Scaffold(
        body: StreamBuilder(
      stream: _messagesStream,
      builder: (context, snap) {
        if (snap.hasError) {
          return Text('Error');
        } else if (!snap.hasData || snap.data.snapshot.value == null) {
          return Container(
              width: w,
              color: Palette().bluebg,
              height: h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      height: 100,
                      // color: Colors.pink,
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                            Container(
                                width: w - 100,
                                child: ListTile(
                                  title: Text(widget.name),
                                  subtitle: Text(
                                    widget.status,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white54),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 70),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: w - 130,
                            child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message..",
                                )),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Palette().bluebg,
                              child: InkWell(
                                child: Icon(Icons.send),
                                onTap: () {
                                  String message_body = messageController.text;
                                  final msgData = MsgData(
                                      author: username,
                                      message_body: message_body,
                                      time: DateTime.now().toString(),
                                      aurora: false,
                                      sticker: null);
                                  _firebaseRef
                                      .child(widget.roomId)
                                      .push()
                                      .set(msgData.toMap())
                                      .then((value) {
                                    messageController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                          InkWell(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Palette().bluebg,
                                child: Icon(Icons.sticky_note_2_rounded),
                              ),
                            ),
                            onTap: () {
                              sendSticker(_firebaseRef, widget, context);
                            },
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Palette().bluebg,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewAurora(widget.roomId)));
                                },
                                icon: Icon(Icons.lock),
                                color: Palette().auroraGreen,
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5)),
                      height: 60,
                    ),
                  )
                ],
              ));
        } else {
          Map data = snap.data.snapshot.value;
          List item = [];

          data.forEach((index, data) => item.add({"key": index, ...data}));
          print("$item ==============");

          return Container(
              width: w,
              color: Palette().bluebg,
              height: h,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 100,
                        // color: Colors.pink,
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                              Container(
                                  width: w - 100,
                                  child: ListTile(
                                    title: Text(widget.name),
                                    subtitle: Text(
                                      widget.status,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white54),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                        )),
                    Container(
                        height: h - 150,
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              if (item[index]['author'] == username) {
                                if (item[index]['aurora'] == true) {
                                  print(item[index]);
                                  return auroraText(
                                      item[index]['key'],
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['message_body'],
                                      context);
                                } else if (item[index]['message_body'] !=
                                    null) {
                                  return sendText(
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['message_body']);
                                } else {
                                  return stickerText(
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['sticker']);
                                }
                              } else if (item[index]['author'] == widget.name) {
                                if (item[index]['aurora'] == true) {
                                  print(item[index]);
                                  return auroraText(
                                      item[index]['key'],
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['message_body'],
                                      context);
                                } else if (item[index]['message_body'] !=
                                    null) {
                                  return receiveText(
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['message_body']);
                                } else {
                                  return stickerText(
                                      item[index]['author'],
                                      item[index]['time'],
                                      item[index]['sticker']);
                                }
                              } else {
                                return Text('hehe');
                              }
                            })),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: w - 130,
                              child: TextField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type a message..",
                                  )),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Palette().bluebg,
                                child: InkWell(
                                  child: Icon(Icons.send),
                                  onTap: () {
                                    String message_body =
                                        messageController.text;
                                    final msgData = MsgData(
                                        author: username,
                                        message_body: message_body,
                                        time: DateTime.now().toString(),
                                        aurora: false,
                                        sticker: null);
                                    _firebaseRef
                                        .child(widget.roomId)
                                        .push()
                                        .set(msgData.toMap())
                                        .then((value) {
                                      messageController.clear();
                                    });
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Palette().bluebg,
                                  child: Icon(Icons.sticky_note_2_rounded),
                                ),
                              ),
                              onTap: () {
                                sendSticker(_firebaseRef, widget, context);
                              },
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                height: 40,
                                width: 40,
                                color: Palette().bluebg,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewAurora(widget.roomId)));
                                  },
                                  icon: Icon(Icons.lock),
                                  color: Palette().auroraGreen,
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)),
                        height: 60,
                      ),
                    )
                  ],
                ),
              ));
        }
      },
    ));
  }
}

stickerText(name, time, url) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(name + "    "),
                Text(time,
                    style: TextStyle(fontSize: 12, color: Colors.white60))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Image.network(
              url,
              width: 120,
            ),
          ],
        ),
      ),
    ),
  );
}

sendText(name, datetime, message) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(name + "    "),
                Text(datetime,
                    style: TextStyle(fontSize: 12, color: Colors.white60))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(message),
          ],
        ),
      ),
    ),
  );
}

receiveText(name, datetime, message) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        color: Colors.blue.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(name + "    "),
                  Text(datetime,
                      style: TextStyle(fontSize: 12, color: Colors.white60))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(message),
            ],
          ),
        ),
      ));
}

// newAurora(context) {
//   String lmao = "";
//   String content = "";
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Palette().bluebg,
//           title: Text("New Aurora"),
//           content: Container(
//             // color: Palette().bluebg.withOpacity(0.8),
//             height: 150,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                     height: 300,
//                     width: 200,
//                     child: Padding(
//                         padding: EdgeInsets.all(20),
//                         child: TextField(
//                           onChanged: (text) {
//                             lmao = text;
//                           },
//                           maxLines: 10,
//                         ))),
//                 MaterialButton(
//                   onPressed: () {
//                     content = stringToBase64.encode(lmao);
//                     sendEncAurora(context, content);
//                   },
//                   child: Text("Encrypt"),
//                   color: Palette().auroraGreen,
//                 )
//               ],
//             ),
//           ),
//           actions: [
//             Center(
//                 child: MaterialButton(
//               minWidth: 150,
//               color: Palette().auroraGreen,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "Tap to View",
//                 style: TextStyle(color: Palette().bluebg),
//               ),
//             ))
//           ],
//         );
//       });
// }

Codec<String, String> stringToBase64 = utf8.fuse(base64);
// sendEncAurora(context, msg) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Palette().bluebg,
//           title: Text("Result"),
//           content: Container(
//             // color: Palette().bluebg.withOpacity(0.8),
//             height: 150,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                     height: 300,
//                     width: 200,
//                     child:
//                         Padding(padding: EdgeInsets.all(20), child: Text(msg))),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Text("Send"),
//                   color: Palette().auroraGreen,
//                 )
//               ],
//             ),
//           ),
//           actions: [
//             Center(
//                 child: MaterialButton(
//               minWidth: 150,
//               color: Palette().auroraGreen,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "Tap to View",
//                 style: TextStyle(color: Palette().bluebg),
//               ),
//             ))
//           ],
//         );
//       });
// }

auroraText(
  id,
  name,
  time,
  msg,
  context,
) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      child: Center(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("$name sent an aurora "),
              Text(
                time.toString().substring(0, 16),
                style: TextStyle(fontSize: 12, color: Colors.white54),
              )
            ],
          ),
          subtitle: MaterialButton(
            color: Colors.blue.withOpacity(0.2),
            onPressed: () {
              //check if enough coins
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(username)
                  .get()
                  .then((value) {
                totalCoins = value.data()['totalCoins'];

                usedCoins = value.data()['usedCoins'];

                int coins = totalCoins - usedCoins;
                int used = usedCoins + 100;
                if (coins >= 100) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(username)
                      .update({'usedCoins': used});
                  successAurora(context, time, name, msg);
                } else {
                  nonsuccessAurora(context, time, name, msg);
                }
              });
            },
            child: Text("Tap to view"),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.pink,
            radius: 20,
          ),
        ),
      ),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Palette().auroraGreen, width: 4),
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}

nonsuccessAurora(context, time, name, msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Palette().bluebg,
          content: Container(
            // color: Palette().bluebg.withOpacity(0.8),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("images/sed_neptune.png", height: 100, width: 100),
                Text("Nearly There!",
                    style: TextStyle(
                        color: Palette().auroraGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(
                    "Aw, you gotta complete just 100\n more steps to view it, goodluck yay!"),
              ],
            ),
          ),
        );
      });
}

successAurora(context, time, name, msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Palette().bluebg,
          content: Container(
            // color: Palette().bluebg.withOpacity(0.8),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("images/happy_neptune.png",
                    height: 100, width: 100),
                Text("Amazing Work",
                    style: TextStyle(
                        color: Palette().auroraGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("Your aurora was descrypted successfully"),
              ],
            ),
          ),
          actions: [
            Center(
                child: MaterialButton(
              minWidth: 150,
              color: Palette().auroraGreen,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Decrypt(time, name, msg)));
              },
              child: Text(
                "Tap to View",
                style: TextStyle(color: Palette().bluebg),
              ),
            ))
          ],
        );
      });
}
