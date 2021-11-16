import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Container(),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(size.height / 12)),
            Center(
              child: Image.asset(
                'assets/icons/car.png',
                height: size.width / 4,
                width: size.width / 3,
              ),
            ),
            Padding(padding: EdgeInsets.all(size.height / 18)),
            Text(
              'TRAVEL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.all(size.width / 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mode of Transport',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: size.width / 6)),
                DropDown1(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.all(size.width / 15)),
                Text(
                  'Vehicle Type',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: size.width / 8)),
                DropDown2(),
                Padding(padding: EdgeInsets.all(size.width / 20)),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(size.width / 15)),
                Text(
                  'Distance (Kms)',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: size.width / 8)),
                DistanceTextField(),
                Padding(padding: EdgeInsets.all(size.width / 20)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DropDown1 extends StatefulWidget {
  DropDown1({
    Key key,
  }) : super(key: key);

  @override
  State<DropDown1> createState() => _DropDown1State();
}

class _DropDown1State extends State<DropDown1> {
  String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
        iconSize: 50,
        iconDisabledColor: Colors.white,
        iconEnabledColor: Colors.white,
        dropdownColor: lightGreen,
        value: value,
        items: <String>['Car', 'Bus', 'Train'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        });
  }
}

class DropDown2 extends StatefulWidget {
  const DropDown2({Key key}) : super(key: key);

  @override
  _DropDown2State createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  String value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        style: TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(208, 222, 216, 1),
        ),
        dropdownColor: lightGreen,
        value: value,
        items: <String>['Two-wheeler', 'Four-wheeler', 'Bicycle']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        });
  }
}

class DistanceTextField extends StatefulWidget {
  const DistanceTextField({Key key}) : super(key: key);

  @override
  _DistanceTextFieldState createState() => _DistanceTextFieldState();
}

class _DistanceTextFieldState extends State<DistanceTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 100,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(208, 222, 216, 1),
          ),
        ));
  }
}
