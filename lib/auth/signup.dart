import 'package:awestruck/auth/login.dart';
import 'package:awestruck/meditation/meditation_home.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
              child: Text("Create an account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 20), child: Text("username")),
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
                padding: EdgeInsets.only(left: 20), child: Text("email")),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(
                20,
              ),
              child: TextField(
                // obscureText: true,
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
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("confirm password")),
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
                "Create an account",
                style: TextStyle(color: Colors.black),
              ),
              color: Color.fromRGBO(3, 202, 164, 1)),
          SizedBox(
            height: 30,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "Already have an account yet? Log In",
                style: TextStyle(color: Colors.blueGrey),
              ))
        ],
      ),
    ));
  }
}
