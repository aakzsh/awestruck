import 'package:awestruck/meditation/meditation_home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  // const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(2, 10, 29, 1),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(30),
              child: Text("Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))),
          MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Meditation()));
              },
              child: Text("Log In with Snapchat"),
              color: Color.fromRGBO(3, 202, 164, 1))
        ],
      ),
    ));
  }
}
