import 'package:awestruck/chat/chat.dart';
import 'package:awestruck/home.dart';
import 'package:awestruck/meditation/meditation_home.dart';
import 'package:awestruck/stars_sighting/star_home.dart';
import 'package:awestruck/walk/walk_home.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class BottomNav extends StatefulWidget {
  final BuildContext menuScreenContext;
  BottomNav({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [StarRoom(), WalkHome(), Home(), Meditation(), Chat()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(EvaIcons.moonOutline),
        title: "StarGazing",
        activeColorPrimary: Color(0xff03CAA4),
        inactiveColorPrimary: Color(0xff0A5E4E),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/star-home': (context) => StarRoom(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.timeline_outlined),
        title: ("Progress"),
        activeColorPrimary: Color(0xff03CAA4),
        inactiveColorPrimary: Color(0xff0A5E4E),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/steps': (context) => WalkHome(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(EvaIcons.homeOutline),
        title: ("Home"),
        activeColorPrimary: Color(0xff03CAA4),
        inactiveColorPrimary: Color(0xff0A5E4E),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/meditation': (context) => Home(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(EvaIcons.heartOutline),
        title: ("Meditation"),
        activeColorPrimary: Color(0xff03CAA4),
        inactiveColorPrimary: Color(0xff0A5E4E),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/meditation': (context) => Meditation(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(EvaIcons.messageCircleOutline),
        title: ("Chat"),
        activeColorPrimary: Color(0xff03CAA4),
        inactiveColorPrimary: Color(0xff0A5E4E),
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => Chat(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Color(0xff0B1630),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        // onWillPop: false,

        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.red,
            borderRadius: BorderRadius.circular(20.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property
      ),
    );
  }
}
