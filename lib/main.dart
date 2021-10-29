import 'package:awestruck/auth/login.dart';
import 'package:awestruck/constant_widgets/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  final token =
      'eyJhbGciOiJIUzI1NiIsImtpZCI6IkNhbnZhc1MyU0hNQUNQcm9kIiwidHlwIjoiSldUIn0.eyJhdWQiOiJjYW52YXMtY2FudmFzYXBpIiwiaXNzIjoiY2FudmFzLXMyc3Rva2VuIiwibmJmIjoxNjM0ODcyODU1LCJzdWIiOiJlYTUxZWJjYy0xNWM1LTQzNTUtOWY1Mi1iNTViYzkxMGY3MzF-U1RBR0lOR34wNjI0MWQyZS1hNTU1LTQxZDAtYmRjNC1lYjYyOTdkOGRkNTkifQ.V7vc3HGR7Od8wRKEV4cS6kuInGn037onaGquQ7c60AI';

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('https://graph.snapchat.com/graphql',
        defaultHeaders: {'Authorization': "Bearer $token"});

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
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
          home: Check()),
    );
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
