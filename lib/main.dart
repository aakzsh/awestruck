import 'package:awestruck/auth/login.dart';
import 'package:awestruck/constant_widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryColor: Colors.pink,
          brightness: Brightness.dark,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
          ),
        ),
        title: "Awestruck",
        home: Check());
  }
}

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return BottomNav();
    } else {
      return Login();
    }
  }
}
