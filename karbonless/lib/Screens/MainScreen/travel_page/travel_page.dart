import 'package:flutter/material.dart';
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
  void dispose() {
    super.dispose();
  }

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
                child: Column(children: [
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
          Padding(
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
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
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
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
                DropDown3(),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(size.width / 25)),
          Padding(
            padding:
                EdgeInsets.only(left: size.width / 20, right: size.width / 20),
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
          Padding(padding: EdgeInsets.only(top: size.height / 8)),
          Container(
            width: size.width / 4,
            child: TextButton(
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
                                future: fetch(store.travelValues),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator.adaptive();
                                  else
                                    return Column(children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.all(size.width / 8)),
                                      Icon(
                                        Icons.done_all_rounded,
                                        color: lightGreen,
                                        size: 80,
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.all(size.width / 15)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'The carbon emission for your recent travel is ${snapshot.data.co2Emission} units and has been sucessfully added to your expenditure',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.all(size.width / 15)),
                                      TextButton(
                                        onPressed: () {
                                          store.fabVisibility = true;

                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
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
                                }),
                          ),
                        );
                      });
                });
              },
              //     child: Text(
              //       "Add",
              //       style: TextStyle(color: darkGreen, fontSize: 30),
              //     ),
              //     style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10.0),
              //         ))),
              //   ),
              // ),
              // FutureBuilder<TravelFootprint>(
              //     future: fetch(store.travelValues),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.none)
              //         return Column(children: [
              //           Padding(
              //             padding: EdgeInsets.only(
              //                 left: size.width / 20, right: size.width / 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Mode of Transport',
              //                   style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 // Padding(padding: EdgeInsets.only(right: size.width / 8)),
              //                 DropDown1(),
              //               ],
              //             ),
              //           ),
              //           Padding(padding: EdgeInsets.all(size.width / 25)),
              //           Padding(
              //             padding: EdgeInsets.only(
              //                 left: size.width / 20, right: size.width / 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Vehicle',
              //                   style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 DropDown2(),
              //               ],
              //             ),
              //           ),
              //           Padding(padding: EdgeInsets.all(size.width / 25)),
              //           Padding(
              //             padding: EdgeInsets.only(
              //                 left: size.width / 20, right: size.width / 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Vehicle Type',
              //                   style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 DropDown3(),
              //               ],
              //             ),
              //           ),
              //           Padding(padding: EdgeInsets.all(size.width / 25)),
              //           Padding(
              //             padding: EdgeInsets.only(
              //                 left: size.width / 20, right: size.width / 20),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   'Distance (Kms)',
              //                   style: TextStyle(
              //                     fontSize: 24,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 DistanceTextField(),
              //               ],
              //             ),
              //           ),
              //           Padding(padding: EdgeInsets.only(top: size.height / 8)),
              //           Container(
              //             width: size.width / 4,
              //             child: TextButton(
              //               onPressed: () async {
              //                 setState(() {
              //                   store.insertTravel();
              //                 });
              //               },
              //               child: Text(
              //                 "Add",
              //                 style: TextStyle(color: darkGreen, fontSize: 30),
              //               ),
              //               style: ButtonStyle(
              //                   backgroundColor:
              //                       MaterialStateProperty.all<Color>(
              //                           Colors.white),
              //                   shape: MaterialStateProperty.all<
              //                           RoundedRectangleBorder>(
              //                       RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                   ))),
              //             ),
              //           )
              //         ]);
              //       else if (snapshot.connectionState ==
              //           ConnectionState.waiting)
              //         return CircularProgressIndicator.adaptive();
              //       else
              //         return Column(children: [
              //           Padding(padding: EdgeInsets.all(size.width / 8)),
              //           Icon(
              //             Icons.done_all_rounded,
              //             color: lightGreen,
              //             size: 80,
              //           ),
              //           Padding(padding: EdgeInsets.all(size.width / 15)),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Center(
              //               child: Text(
              //                 'The carbon emission for your recent travel is ${snapshot.data.co2Emission} units and has been sucessfully added to your expenditure',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontSize: 25,
              //                   // fontWeight: FontWeight.bold,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(padding: EdgeInsets.all(size.width / 15)),
              //           TextButton(
              //             onPressed: () {
              //               store.fabVisibility = true;

              //               Navigator.pop(context);
              //             },
              //             child: Text(
              //               "Done",
              //               style: TextStyle(color: darkGreen, fontSize: 30),
              //             ),
              //             style: ButtonStyle(
              //                 backgroundColor: MaterialStateProperty.all<Color>(
              //                     Colors.white),
              //                 shape: MaterialStateProperty.all<
              //                         RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10.0),
              //                 ))),
              //           )
              //         ]);
              //     }),
            ),
          )
        ]))));
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
    MyStore store = VxState.store;
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
          items: <String>['Land', 'Air', 'Water'].map((String value) {
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
            items: <String>['Two Wheelers', 'Four-wheeler', 'Bicycle']
                .map((String value) {
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
            }));
  }
}

class DropDown3 extends StatefulWidget {
  const DropDown3({Key key}) : super(key: key);

  @override
  _DropDown3State createState() => _DropDown3State();
}

class _DropDown3State extends State<DropDown3> {
  String value;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
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
            items: <String>['Bike', 'Scooter', 'Bicycle'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                store.travelValues.vehicle = newValue;
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
    MyStore store = VxState.store;
    store.distanceController = controller;
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

Future<TravelFootprint> fetch(InsertTravelValues values) async {
  String vehicleType = values.vehicleType;
  String vehicle = values.vehicle;
  String mode = values.mode;
  String distance = values.distance.toString();
  print(
      'https://karbonless-api.herokuapp.com/footprint/travel?type=$vehicleType, $vehicle&mode=$mode&distance=$distance');
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/footprint/travel?type=$vehicleType, $vehicle&mode=$mode&distance=$distance'),
    headers: <String, String>{
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTkzZjg1MTBlZmQ0MTAwMTY4ZDMzZjYiLCJpYXQiOjE2MzcyMzE4NDZ9.mUr1j8NLn3tu_pszz7xSqlXAPY4JDFXREpsboYZxpm0'
    },
  );
  print(response.body);
  final footprint = travelFootprintFromJson(response.body);
  return footprint;
}
