import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:circular_menu/circular_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'Screens/MainScreen/body/bottom_nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karbonless',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: ScaffoldWidget(),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: CircularMenu(
            alignment: Alignment.center,
            startingAngleInRadian: 3.49,
            endingAngleInRadian: 5.93,
            toggleButtonPadding: 0,
            toggleButtonMargin: 0,
            toggleButtonSize: 60,
            toggleButtonBoxShadow: [],
            toggleButtonIconColor: Color.fromRGBO(24, 57, 43, 1),
            toggleButtonAnimatedIconData: AnimatedIcons.add_event,
            items: [
              CircularMenuItem(
                onTap: () {},
                icon: Icons.train_outlined,
                iconColor: Color.fromRGBO(24, 57, 43, 1),
                iconSize: 38,
                padding: 5,
                margin: 0,
              ),
              CircularMenuItem(
                onTap: () {},
                icon: Icons.food_bank_outlined,
                iconColor: Color.fromRGBO(24, 57, 43, 1),
                iconSize: 40,
                padding: 8,
                margin: 0,
              ),
              CircularMenuItem(
                onTap: () {},
                icon: Icons.shopping_cart_outlined,
                iconColor: Color.fromRGBO(24, 57, 43, 1),
                iconSize: 38,
                padding: 5,
                margin: 0,
              ),
            ],
          ),
        ),
        // FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   foregroundColor:  Color.fromRGBO(24, 57, 43, 1),
        //   child:
        //   onPressed: () {},
        // ),
        body: SafeArea(child: MainScreen()));
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
        iconSize: 28,
        onTap: (newIndex) {
          setState(() {
            activeIndex = newIndex;
          });
        },
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        activeColor: Color.fromRGBO(24, 57, 43, 1),
        inactiveColor: Colors.grey,
        icons: <IconData>[
          Icons.home_outlined,
          Icons.sticky_note_2_outlined,
          Icons.star_border_purple500_outlined,
          Icons.account_circle_outlined
        ]);
  }
}
