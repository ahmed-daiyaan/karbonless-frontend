import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainScreen/body/fab_bar.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'Screens/MainScreen/body/bottom_nav.dart';
import 'Screens/MainScreen/body/overlay.dart';
import 'Screens/MainScreen/travel_page/travel_page.dart';

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
        floatingActionButton: _buildFab(context),
        body: SafeArea(child: MainScreen()));
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FABBottomAppBar(
      color: Colors.grey,
      selectedColor: Color.fromRGBO(88, 139, 118, 1),
      onTabSelected: (selectedIndex) {},
      notchedShape: CircularNotchedRectangle(),
      items: [
        FABBottomAppBarItem(
          iconData: Icons.home_outlined,
          text: 'Home',
        ),
        FABBottomAppBarItem(
          iconData: Icons.receipt_outlined,
          text: 'History',
        ),
        FABBottomAppBarItem(
          iconData: Icons.star_border_purple500_outlined,
          text: 'Badges',
        ),
        FABBottomAppBarItem(
          iconData: Icons.account_circle_outlined,
          text: 'Profile',
        )
      ],
    );
  }
}

Widget _buildFab(BuildContext context) {
  final icons = [
    Icons.train_outlined,
    Icons.food_bank_outlined,
    Icons.shopping_cart_outlined
  ];
  return AnchoredOverlay(
    showOverlay: true,
    overlayBuilder: (context, offset) {
      return CenterAbout(
        position: Offset(offset.dx, offset.dy - icons.length * 35.0),
        child: FabWithIcons(
          icons: icons,
          onIconTapped: (int value) {
            if (value == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TravelPage()));
            }
          },
        ),
      );
    },
    child: FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.white,
      foregroundColor: Color.fromRGBO(88, 139, 118, 1),
      tooltip: 'Add Event',
      child: Icon(
        Icons.safety_divider,
        color: Color.fromRGBO(88, 139, 118, 1),
      ),
      elevation: 2.0,
    ),
  );
}
