import 'dart:async';

import 'package:awestruck/auth/signup.dart';
import 'package:awestruck/constant_widgets/palette.dart';
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
    double w = MediaQuery.of(context).size.width;
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 20), child: Text("email")),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: ""),
              ),
            ),
            height: 50,
            width: w - 40,
            color: Colors.blue.withOpacity(0.1),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 20), child: Text("password")),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration.collapsed(hintText: ""),
              ),
            ),
            height: 50,
            width: w - 40,
            color: Colors.blue.withOpacity(0.1),
          ),
          SizedBox(height: 40),
          MaterialButton(
              minWidth: w - 40,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Meditation()));
              },
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.black),
              ),
              color: Color.fromRGBO(3, 202, 164, 1)),
          SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
              child: Text(
                "Dont't have an account yet? Create one",
                style: TextStyle(color: Colors.blueGrey),
              ))
        ],
      ),
    ));
  }
}
