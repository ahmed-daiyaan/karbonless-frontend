import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Badges/badges_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';

import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Screens/Dashboard/dashboard.dart';
import 'Screens/Dashboard/widgets/bottom_nav_bar.dart';
import 'Screens/History/history.dart';
import 'Screens/User/user_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('karbonizeToken') ?? 'Not Found';
  String name = preferences.getString('karbonizeName') ?? 'Not Found';
  runApp(VxState(store: MyStore(), child: const MyApp()));
  MyStore store = VxState.store;
  store.currentToken = token;
  store.currentUser = name;
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Karbonless',
      theme: ThemeData(
        fontFamily: 'Actor',
        primaryColor: Colors.white,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      home: store.currentToken == 'Not Found'
          ? LoginScreen()
          : const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
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
          children: [Dashboard(), History(), Badges(), User()],
        )));
  }
}
