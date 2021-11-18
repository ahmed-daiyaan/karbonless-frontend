import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainScreen/widgets/bottom_nav_bar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Screens/MainScreen/main_screen.dart';

void main() => runApp(VxState(store: MyStore(), child: MyApp()));

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
      home: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FabBuilder(),
          body: SafeArea(child: MainScreen())),
    );
  }
}
