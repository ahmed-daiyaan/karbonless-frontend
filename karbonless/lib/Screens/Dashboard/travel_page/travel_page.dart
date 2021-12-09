import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/travel_page/travel_details.dart';
import 'package:flutter_auth/Screens/History/history.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/travel_footprint.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class TravelPage extends StatefulWidget {
  const TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  void initState() {
    MyStore store = VxState.store;
    store.fabVisibility = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        store.fabVisibility = true;
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // bottomNavigationBar: BottomNavBar(),
          floatingActionButton: Container(),
          body: SafeArea(
              child: Container(
                  child: Column(children: [
            Padding(padding: EdgeInsets.all(size.height / 35)),
            Center(
              child: Image.asset(
                'assets/icons/car.png',
                height: size.width / 4,
                width: size.width / 3,
              ),
            ),
            Padding(padding: EdgeInsets.all(size.height / 35)),
            const Text(
              'TRAVEL',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width / 20,
                  right: size.width / 20,
                  top: size.width / 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
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
                children: const [
                  Text(
                    'Vehicle',
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
                children: const [
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
            Padding(padding: EdgeInsets.only(top: size.height / 8)),
            Container(
              width: size.width / 4,
              child: TextButton(
                child: const Text(
                  "Add",
                  style: const TextStyle(color: darkGreen, fontSize: 30),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () async {
                  setState(() {
                    store.insertTravel();

                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Card(
                              color: darkGreen,
                              child: FutureBuilder<TravelFootprint>(
                                  future: fetchEmission(store.travelValues),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator
                                          .adaptive();
                                    } else {
                                      return Column(children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.all(size.width / 8)),
                                        const Icon(
                                          Icons.done_all_rounded,
                                          color: lightGreen,
                                          size: 80,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(
                                                size.width / 15)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              'The carbon emission for your recent travel is  ${roundDouble(snapshot.data.totalEmission, 4)} units and has been sucessfully added to your expenditure',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 25,
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.all(
                                                size.width / 15)),
                                        TextButton(
                                          onPressed: () {
                                            store.fabVisibility = true;

                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Done",
                                            style: const TextStyle(
                                                color: darkGreen, fontSize: 30),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ))),
                                        )
                                      ]);
                                    }
                                  }),
                            ),
                          );
                        });
                  });
                },
              ),
            )
          ])))),
    );
  }
}

Future<List<String>> fetchModes() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/footprint/travel/all'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );

  List<String> modes = List<String>();
  final travelDetails = travelDetailsFromJson(response.body);
  print('Length: ${travelDetails.length}');
  for (int i = 0; i < travelDetails.length; i++) {
    modes.add(travelDetails[i].mode);
  }
  modes = modes.toSet().toList();
  print(modes);
  return modes;
}

Future<List<String>> fetchTypes() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/footprint/travel/all'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );

  List<String> types = List<String>();
  final travelDetails = travelDetailsFromJson(response.body);
  for (int i = 0; i < travelDetails.length; i++) {
    types.add(travelDetails[i].type);
  }
  types = types.toSet().toList();
  print(types);
  return types;
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
    MyStore store = VxState.store;
    return Container(
      width: 150,
      height: 60,
      child: FutureBuilder<List<String>>(
          future: fetchModes(),
          builder: (context, snapshot) {
            return DropdownButtonFormField<String>(
                isDense: false,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    fillColor: lightGreen),
                // underline: Container(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                iconSize: 20,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                dropdownColor: lightGreen,
                value: value,
                items: !snapshot.hasData
                    ? <String>['...'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : snapshot.data.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    store.travelValues.mode = newValue;
                    value = newValue;
                  });
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
    MyStore store = VxState.store;
    return Container(
        width: 150,
        height: 60,
        child: FutureBuilder<List<String>>(
            future: fetchTypes(),
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
                  isDense: false,
                  isExpanded: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: lightGreen),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  iconSize: 20,
                  dropdownColor: lightGreen,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  value: value,
                  items: !snapshot.hasData
                      ? <String>['...'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : snapshot.data.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      store.travelValues.vehicleType = newValue;
                      value = newValue;
                    });
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
    MyStore store = VxState.store;
    store.distanceController = controller;
    return Container(
        height: 60,
        width: 150,
        child: TextField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              filled: true,
              fillColor: lightGreen),
          textAlign: TextAlign.end,
          keyboardType: TextInputType.number,
          controller: controller,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ));
  }
}

Future<TravelFootprint> fetchEmission(InsertTravelValues values) async {
  MyStore store = VxState.store;

  String vehicleType = values.vehicleType;
  String mode = values.mode;
  String distance = values.distance.toString();
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/footprint/travel?type=$vehicleType&mode=$mode&distance=$distance'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final footprint = travelFootprintFromJson(response.body);
  return footprint;
}
