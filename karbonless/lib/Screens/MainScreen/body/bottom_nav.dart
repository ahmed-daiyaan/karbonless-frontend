import 'package:flutter/material.dart';

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
                Text(
                  'Spent: 2.3 kg of CO2',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BarAndBadge extends StatefulWidget {
  const BarAndBadge({Key key}) : super(key: key);

  @override
  _BarAndBadgeState createState() => _BarAndBadgeState();
}

class _BarAndBadgeState extends State<BarAndBadge> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(children: [
              Text(
                '23 more points to unlock badge',
                style: TextStyle(
                    fontSize: 22, color: Color.fromRGBO(208, 222, 216, 1)),
              ),
              Container(
                width: size.width / 1.5,
                child: Slider(
                  inactiveColor: Colors.white,
                  activeColor: Color.fromRGBO(88, 139, 118, 1),
                  value: 80,
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(88, 139, 118, 1),
              ),
            ),
          )
        ],
      ),
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
          ],
        ),
      ),
    );
  }
}
