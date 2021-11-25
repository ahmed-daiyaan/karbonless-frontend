import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/MainScreen/user/userActivityRead.dart';
import 'package:flutter_auth/Screens/MainScreen/user/userRead.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/iconHierarchy.dart';
import 'package:flutter_auth/store/logs.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Greeting(), LimitSpent(), BarAndBadge(), RecentLogs()],
    );
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
    var now = DateTime.now();
    print(now.hour);
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: Row(
        children: [
          now.hour >= 16
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
          now.hour >= 16
              ? Text(
                  "Good Evening, Vaish",
                  style: TextStyle(
                      fontFamily: 'PT Sans',
                      fontSize: 25,
                      color: Color.fromRGBO(208, 222, 216, 1)),
                )
              : Text(
                  "Good Morning, Vaish",
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(208, 222, 216, 1)),
                )
        ],
      ),
    ));
  }
}

Future<String> getSpent() async {
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?duration=currentDay'),
    headers: <String, String>{
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTkzZjg1MTBlZmQ0MTAwMTY4ZDMzZjYiLCJpYXQiOjE2MzcyMzE4NDZ9.mUr1j8NLn3tu_pszz7xSqlXAPY4JDFXREpsboYZxpm0'
    },
  );
  final userActivityRead = userActivityFromJson(response.body);
  double totalSpent = 0.0;
  for (int i = 0; i < userActivityRead.length; i++) {
    totalSpent += userActivityRead[i].co2Emission;
  }
  return totalSpent.toStringAsFixed(1);
}

class LimitSpent extends StatefulWidget {
  const LimitSpent({Key key}) : super(key: key);

  @override
  _LimitSpentState createState() => _LimitSpentState();
}

class _LimitSpentState extends State<LimitSpent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(88, 139, 118, 1),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(
              'assets/images/earth.png',
              width: size.width / 2.5,
              height: size.width / 2.5,
            ),
            Column(
              children: [
                Text(
                  'Limit: 4.5 kg of CO2',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Padding(padding: EdgeInsets.all(6)),
                FutureBuilder<String>(
                    future: getSpent(),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.connectionState == ConnectionState.waiting
                            ? '...'
                            : 'Spent: ' + snapshot.data + ' kg of CO2',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<int> readKredits() async {
  MyStore store = VxState.store;
  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/users/me'),
    headers: <String, String>{
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTkzZjg1MTBlZmQ0MTAwMTY4ZDMzZjYiLCJpYXQiOjE2MzcyMzE4NDZ9.mUr1j8NLn3tu_pszz7xSqlXAPY4JDFXREpsboYZxpm0'
    },
  );
  final user = userReadFromJson(response.body);
  store.no_of_badges = user.kredit ~/ 100;
  print(store.no_of_badges);
  return user.kredit % 100;
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
    return Container(
      child: FutureBuilder<int>(
          future: readKredits(),
          builder: (context, snapshot) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(children: [
                    Text(
                      snapshot.connectionState == ConnectionState.waiting
                          ? '...'
                          : '${snapshot.data} more points to unlock badge',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromRGBO(208, 222, 216, 1)),
                    ),
                    Container(
                      width: size.width / 1.5,
                      child: Slider(
                        inactiveColor: Colors.white,
                        activeColor: Color.fromRGBO(88, 139, 118, 1),
                        value:
                            snapshot.connectionState == ConnectionState.waiting
                                ? 0
                                : 100 - snapshot.data.toDouble(),
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
                    height: size.width / 5,
                    width: size.width / 5,
                    child: snapshot.connectionState == ConnectionState.waiting
                        ? Container()
                        : Container(
                            height: size.width / 5,
                            width: size.width / 5,
                            child: IconHierarchy().badges[store.no_of_badges]),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(88, 139, 118, 1),
                    ),
                  ),
                )
              ],
            );
          }),
    );
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
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return Padding(
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
                style: TextStyle(
                    fontSize: 25, color: Color.fromRGBO(208, 222, 216, 1)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(color: Color.fromRGBO(24, 57, 43, 1), height: 5),
            FutureBuilder<List<Logs>>(
                future: fetchRecentLogs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Padding(
                      padding: EdgeInsets.only(top: size.height / 12),
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  else
                    return Column(
                      children: List<Widget>.generate(
                          snapshot.data.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Text(
                                  snapshot.data[index].category +
                                      ' - ' +
                                      snapshot.data[index].co2Emission
                                          .toString() +
                                      ' - ' +
                                      snapshot.data[index].kredit.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              )),
                    );
                })
            // Center(
            //   child: Column(
            //     children: List<Widget>.generate(
            //       store.events.length,
            //       (index) => Text(
            //         store.events[index],
            //         style: TextStyle(fontSize: 12, color: lightGreen),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

Future<List<Logs>> fetchRecentLogs() async {
  print(
      'https://karbonless-api.herokuapp.com/activity?sortBy=type:desc&limit=5');
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?sortBy=type:desc&limit=5'),
    headers: <String, String>{
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTkzZjg1MTBlZmQ0MTAwMTY4ZDMzZjYiLCJpYXQiOjE2MzcyMzE4NDZ9.mUr1j8NLn3tu_pszz7xSqlXAPY4JDFXREpsboYZxpm0'
    },
  );
  print(response.body);
  final logs = logsFromJson(response.body);
  return logs;
}
