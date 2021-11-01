import 'package:awestruck/auth/login.dart';
import 'package:awestruck/constant_widgets/bottom_nav.dart';
import 'package:awestruck/stars_sighting/gaze.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

LocationData _location;

class _AppState extends State<App> {
  final Location location = Location();

  bool _loading = false;

  String _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        _loading = false;
      });
      setState(() {
        lat = _location.latitude;
        lng = _location.longitude;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  final token =
      'eyJhbGciOiJIUzI1NiIsImtpZCI6IkNhbnZhc1MyU0hNQUNQcm9kIiwidHlwIjoiSldUIn0.eyJhdWQiOiJjYW52YXMtY2FudmFzYXBpIiwiaXNzIjoiY2FudmFzLXMyc3Rva2VuIiwibmJmIjoxNjM0ODcyODU1LCJzdWIiOiJlYTUxZWJjYy0xNWM1LTQzNTUtOWY1Mi1iNTViYzkxMGY3MzF-U1RBR0lOR34wNjI0MWQyZS1hNTU1LTQxZDAtYmRjNC1lYjYyOTdkOGRkNTkifQ.V7vc3HGR7Od8wRKEV4cS6kuInGn037onaGquQ7c60AI';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getLocation());
  }

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
