import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Container(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(size.height / 20)),
              Center(
                child: Image.asset(
                  'assets/icons/car.png',
                  height: size.width / 4,
                  width: size.width / 3,
                ),
              ),
              Padding(padding: EdgeInsets.all(size.height / 35)),
              Text(
                'TRAVEL',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(size.width / 25)),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width / 20, right: size.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mode of Transport',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    // Padding(padding: EdgeInsets.only(right: size.width / 8)),
                    DropDown1(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(size.width / 25)),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width / 20, right: size.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vehicle Type',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    DropDown2(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(size.width / 25)),
              Padding(
                padding: EdgeInsets.only(
                    left: size.width / 20, right: size.width / 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Distance (Kms)',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    DistanceTextField(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: size.height / 7)),
              Container(
                width: size.width / 4,
                child: TextButton(
                  onPressed: () {
                    store.insertTravel();
                    // store.fabVisibility = true;
                    // Navigator.pop(context);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: darkGreen, fontSize: 30),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                ),
              )
            ],
          ),
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
    return Container(
      width: 120,
      height: 60,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              fillColor: lightGreen),
          // underline: Container(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          iconSize: 20,
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
          }),
    );
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
    return Container(
        width: 140,
        height: 60,
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                fillColor: lightGreen),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            iconSize: 20,
            dropdownColor: lightGreen,
            iconDisabledColor: Colors.white,
            iconEnabledColor: Colors.white,
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
            }));
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
        height: 60,
        width: 120,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              fillColor: lightGreen),
          textAlign: TextAlign.end,
          keyboardType: TextInputType.number,
          controller: controller,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ));
  }
}
