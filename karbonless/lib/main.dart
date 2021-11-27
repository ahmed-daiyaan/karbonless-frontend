import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Badges/badges_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/MainScreen/widgets/bottom_nav_bar.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Screens/MainScreen/main_screen.dart';

void main() => runApp(VxState(store: MyStore(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karbonless',
      theme: ThemeData(
        fontFamily: 'PTSans',
        primaryColor: Colors.white,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: LoginScreen(),
    );
  }
}

class MainPart extends StatefulWidget {
  const MainPart({
    Key key,
  }) : super(key: key);

  @override
  State<MainPart> createState() => _MainPartState();
}

class _MainPartState extends State<MainPart> with TickerProviderStateMixin {
  MyStore store = VxState.store;
  @override
  void initState() {
    store.pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabBuilder(),
        body: SafeArea(
            child: PageView(
          controller: store.pageController,
          children: [MainScreen(), Badges(), Hello(), Free()],
        )));
  }
}

class Hello extends StatelessWidget {
  const Hello({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Free extends StatelessWidget {
  const Free({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
