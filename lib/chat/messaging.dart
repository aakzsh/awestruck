import 'package:awestruck/constant_widgets/palette.dart';
import 'package:flutter/material.dart';

class Messaging extends StatefulWidget {
  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: w,
        color: Palette().bluebg,
        height: h,
        child: SingleChildScrollView(

          child: Column(
          children: <Widget>[
            Container(
              height: 100,
              // color: Colors.pink,
              child: Center(child: 
              Row(
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
                        title: Text("Amanda"),
                        subtitle: Text(
                          "meditating",
                          style: TextStyle(fontSize: 11, color: Colors.white54),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                      ))
                ],
              ),
              )
            ),
            Container(
              height: h - 220,
              child: ListView(children: <Widget>[
                sendText("Amanda", "Today at 10:12", "Hello i'm Amanda"),
                receiveText("frooti", "Today at 10:13", "sach bamtao"),
                auroraText()
              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: w - 130,
                      child: TextField(
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
                        child: Icon(Icons.sticky_note_2_rounded),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Palette().bluebg,
                        child: Icon(
                          Icons.lock,
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
        )
      ),
    );
  }
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

auroraText() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
      child: Center(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Sent an aurora"),
              Text(
                "9:50",
                style: TextStyle(fontSize: 12, color: Colors.white54),
              )
            ],
          ),
          subtitle: MaterialButton(
            color: Colors.blue.withOpacity(0.2),
            onPressed: () {},
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
