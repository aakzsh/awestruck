import 'package:awestruck/auth/login.dart';
import 'package:flutter/material.dart';

class Decide extends StatefulWidget {
  const Decide({Key? key}) : super(key: key);

  @override
  _DecideState createState() => _DecideState();
}

class _DecideState extends State<Decide> {
  bool isLogged = true;
  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      return Home();
    } else {
      return Login();
    }
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
