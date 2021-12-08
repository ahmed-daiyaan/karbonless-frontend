// ignore_for_file: prefer_const_constructors

// import 'package:background_location/background_location.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/travel_page/travel_page.dart';
import 'package:flutter_auth/Screens/Dashboard/user/userActivityRead.dart';
import 'package:flutter_auth/Screens/Dashboard/user/userRead.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/iconHierarchy.dart';
import 'package:flutter_auth/store/logs.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import 'food_page/food_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void selectNotification(String payload) async {
      MyStore store = VxState.store;
      store.fabVisibility = false;
      if (payload == 'Travel') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TravelPage()));
      } else if (payload == 'Food') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FoodPage()));
      }
    }

    getPermission(selectNotification);
    return Column(
      children: const [
        Greeting(),
        // LimitSpent(),
        BarAndBadge(),
        FootprintToday()
        //  RecentLogs()
      ],
    );
  }

  getPermission(Function selectNotification) async {
    MyStore store = VxState.store;
    FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('app_icon');
    InitializationSettings settings =
        InitializationSettings(android: androidSettings);
    await plugin.initialize(settings, onSelectNotification: selectNotification);
    store.plugin = plugin;
    if (await Permission.location.status.isDenied) {
      Permission.location.request();
    }
    LocationData locationData;
    Location location = Location();
    location.enableBackgroundMode(enable: true);
    location.changeSettings(interval: 5000, distanceFilter: 1000);
    locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) async {
      AndroidNotificationDetails and = AndroidNotificationDetails(
          '1', 'Karbonize',
          largeIcon: DrawableResourceAndroidBitmap("app_icon"),
          subText: 'Hello',
          ongoing: true);
      NotificationDetails platform = NotificationDetails(android: and);
      await plugin.show(1, 'Location Change Detected',
          'Are you moving in an vehicle? Click to add', platform,
          payload: 'Travel');
    });
  }
}

class Greeting extends StatefulWidget {
  const Greeting({Key key}) : super(key: key);

  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    var now = DateTime.now();
    print(now.hour);
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: Row(
        children: [
          now.hour >= 16 && now.hour <= 24
              ? Image.asset(
                  'assets/icons/moon.png',
                  width: size.width / 8,
                  height: size.width / 8,
                )
              : Image.asset(
                  'assets/icons/sun.png',
                  width: size.width / 8,
                  height: size.width / 8,
                ),
          Padding(padding: EdgeInsets.only(right: size.width / 20)),
          now.hour >= 16 && now.hour <= 24
              ? AutoSizeText(
                  "Good Evening, ${store.currentUser}",
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                      fontFamily: 'PTSans',
                      fontSize: 25,
                      color: Color.fromRGBO(208, 222, 216, 1)),
                )
              : AutoSizeText(
                  "Good Morning, ${store.currentUser}",
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(208, 222, 216, 1)),
                )
        ],
      ),
    ));
  }
}

Future<List<double>> getSpent() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?duration=currentDay'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final userActivityRead = userActivityFromJson(response.body);
  double totalSpent = 0.0;
  double travelSpent = 0.0;
  double foodSpent = 0.0;
  double productSpent = 0.0;
  for (int i = 0; i < userActivityRead.length; i++) {
    totalSpent += userActivityRead[i].totalEmission;
    if (userActivityRead[i].category == "Travel")
      travelSpent += userActivityRead[i].totalEmission;
    else if (userActivityRead[i].category == "Food")
      foodSpent += userActivityRead[i].totalEmission;
    else
      productSpent += userActivityRead[i].totalEmission;
  }
  return [travelSpent, foodSpent, productSpent, totalSpent];
}

// class LimitSpent extends StatefulWidget {
//   const LimitSpent({Key key}) : super(key: key);

//   @override
//   _LimitSpentState createState() => _LimitSpentState();
// }

// class _LimitSpentState extends State<LimitSpent> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.all(14.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Color.fromRGBO(88, 139, 118, 1),
//             borderRadius: BorderRadius.circular(10)),
//         padding: EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Image.asset(
//               'assets/images/earth.png',
//               width: size.width / 2.5,
//               height: size.width / 2.5,
//             ),
//             Column(
//               children: [
//                 Text(
//                   'Limit: 4.5 kg of CO2',
//                   style: TextStyle(fontSize: 20, color: Colors.white),
//                 ),
//                 Padding(padding: EdgeInsets.all(6)),
//                 FutureBuilder<String>(
//                     future: getSpent(),
//                     builder: (context, snapshot) {
//                       return Text(
//                         snapshot.connectionState == ConnectionState.waiting
//                             ? '...'
//                             : 'Spent: ' + snapshot.data + ' kg of CO2',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       );
//                     }),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Future<int> readKredits() async {
  MyStore store = VxState.store;
  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/users/me'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final user = userReadFromJson(response.body);
  store.userId = user.id;
  store.no_of_badges = user.kredit ~/ 100;
  setCount();
  print(user.kredit);
  print(user.kredit % 100);
  return user.kredit % 100;
}

setCount() async {
  MyStore store = VxState.store;
  int count;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('badgeCount')) {
    count = prefs.getInt('badgeCount');
  } else {
    prefs.setInt('badgeCount', 0);
    count = 0;
  }
  store.oldBadgeCount = count;
}

class BarAndBadge extends StatefulWidget {
  const BarAndBadge({Key key}) : super(key: key);

  @override
  _BarAndBadgeState createState() => _BarAndBadgeState();
}

class _BarAndBadgeState extends State<BarAndBadge> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<int>(
        future: readKredits(),
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  AutoSizeText(
                    snapshot.connectionState == ConnectionState.waiting
                        ? '...'
                        : '${100 - snapshot.data} more kredits to unlock badge',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(208, 222, 216, 1)),
                  ),
                  SizedBox(
                    width: size.width / 1.7,
                    child: Slider(
                      inactiveColor: Colors.white,
                      activeColor: Color.fromRGBO(88, 139, 118, 1),
                      value: snapshot.connectionState == ConnectionState.waiting
                          ? 0
                          : snapshot.data.toDouble(),
                      onChanged: (newValue) {},
                      min: 0,
                      max: 100,
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.width / 6,
                  width: size.width / 6,
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? Container()
                      : SizedBox(
                          height: size.width / 6,
                          width: size.width / 6,
                          child: IconHierarchy().badges[store.no_of_badges]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(88, 139, 118, 1),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class RecentLogs extends StatefulWidget {
  const RecentLogs({Key key}) : super(key: key);

  @override
  _RecentLogsState createState() => _RecentLogsState();
}

class _RecentLogsState extends State<RecentLogs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          height: size.height / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(88, 139, 118, 1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Recent Logs',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(color: Color.fromRGBO(24, 57, 43, 1), height: 5),
              FutureBuilder<List<Logs>>(
                  future: fetchRecentLogs(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: size.height / 12),
                        child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    } else {
                      return Column(
                        children: List<Widget>.generate(
                            snapshot.data.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: Text(
                                    snapshot.data[index].category +
                                        ' - ' +
                                        snapshot.data[index].totalEmission
                                            .toStringAsFixed(3) +
                                        ' - ' +
                                        snapshot.data[index].kredit.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                )),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Logs>> fetchRecentLogs() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/activity?limit=5'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final logs = logsFromJson(response.body);
  return logs;
}

class FootprintToday extends StatefulWidget {
  const FootprintToday({Key key}) : super(key: key);

  @override
  _FootprintTodayState createState() => _FootprintTodayState();
}

class _FootprintTodayState extends State<FootprintToday> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Padding(padding: EdgeInsets.only(top: 30)),
      const Center(
          child: AutoSizeText(
        'Your Footprint Today',
        style: TextStyle(color: Colors.white, fontSize: 35),
      )),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(color: lightGreen, width: size.width - 100, height: 5),
      ),
      // Padding(padding: EdgeInsets.only(top: 40)),
      FutureBuilder<List<double>>(
          future: getSpent(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0, left: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        // height: ,
                        height: size.width / 3 - 30,
                        width: size.width / 3 - 30,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/icons/car.png',
                                  height: size.width / 6 - 35,
                                  color: darkGreen,
                                ),
                              ),
                              Center(
                                  child: AutoSizeText(
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? '...'
                                          : snapshot.data[0].toStringAsFixed(1),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: darkGreen, fontSize: 40)))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      height: size.width / 3 - 30,
                      width: size.width / 3 - 30,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/food1.png',
                                height: size.width / 6 - 35,
                                color: darkGreen,
                              ),
                            ),
                            Center(
                                child: AutoSizeText(
                                    snapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? '...'
                                        : snapshot.data[1].toStringAsFixed(1),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: darkGreen, fontSize: 40)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0, right: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        height: size.width / 3 - 30,
                        width: size.width / 3 - 30,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/cart1.png',
                                  height: size.width / 6 - 35,
                                  color: darkGreen,
                                ),
                              ),
                              Center(
                                  child: AutoSizeText(
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? '...'
                                          : snapshot.data[2].toStringAsFixed(1),
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: darkGreen, fontSize: 40)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        height: size.width / 2.1,
                        width: size.width / 2.1,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Stack(
                            children: [
                              Positioned(
                                  top: 35,
                                  left: 35,
                                  child: Container(
                                    width: size.width / 4.5,
                                    child: AutoSizeText(
                                        snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? '...'
                                            : snapshot.data[3]
                                                .toStringAsFixed(1),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: darkGreen, fontSize: 50)),
                                  )),
                              Positioned(
                                top: constraints.maxHeight / 2,
                                left: 13,
                                // left: constraints.maxHeight / 2,
                                // top: constraints.maxWidth / 2,
                                child: Transform.rotate(
                                  angle: 15,
                                  // quarterTurns: 2,
                                  child: Container(
                                    height: 3,
                                    width: size.width / 2.1 - 30,
                                    color: darkGreen,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 35,
                                  right: 35,
                                  child: Text('4.5',
                                      style: TextStyle(
                                          color: darkGreen, fontSize: 50))),
                            ],
                          );
                        }),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: AutoSizeText(
            'kg of CO2',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              color: Vx.white,
            ),
          ),
        ),
      )
    ]);
  }
}
