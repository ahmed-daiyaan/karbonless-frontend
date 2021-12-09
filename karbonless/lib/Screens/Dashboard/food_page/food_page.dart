import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/History/history.dart';
import 'package:flutter_auth/store/food_footprint.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../store/vxstore.dart';
import 'food_details.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
                'assets/icons/food.png',
                height: size.width / 4,
                width: size.width / 3,
              ),
            ),
            Padding(padding: EdgeInsets.all(size.height / 35)),
            const Text(
              'FOOD',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                    'Choose Food',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(right: size.width / 8)),
                  FoodDropDown1(),
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
                    'Quantity (in kg)',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  QuantityTextField(),
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
                    store.insertFood();

                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Card(
                              color: darkGreen,
                              child: FutureBuilder<FoodFootprint>(
                                  future: fetchEmission(store.foodValues),
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
                                              'The carbon emission for your consumption is ${roundDouble(snapshot.data.totalEmission, 4)} units and has been sucessfully added to your expenditure',
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

  Future<FoodFootprint> fetchEmission(InsertFoodValues values) async {
    MyStore store = VxState.store;

    String food = values.food;
    int quantity = values.quantity;
    print(
        'https://karbonless-api.herokuapp.com/footprint/food?type=$food&quantity=$quantity');
    var response = await http.get(
      Uri.parse(
          'https://karbonless-api.herokuapp.com/footprint/food?type=$food&quantity=$quantity'),
      headers: <String, String>{
        'Authorization': 'Bearer ${store.currentToken}'
      },
    );
    print(response.body);
    final footprint = foodFootprintFromJson(response.body);
    return footprint;
  }
}

class FoodDropDown1 extends StatefulWidget {
  const FoodDropDown1({Key key}) : super(key: key);

  @override
  _FoodDropDown1State createState() => _FoodDropDown1State();
}

class _FoodDropDown1State extends State<FoodDropDown1> {
  String value;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    return Container(
        width: 150,
        height: 60,
        child: FutureBuilder<List<String>>(
            future: fetchFood(),
            builder: (context, snapshot) {
              return DropdownButtonFormField<String>(
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
                      store.foodValues.food = newValue;
                      value = newValue;
                    });
                  });
            }));
  }
}

Future<List<String>> fetchFood() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse('https://karbonless-api.herokuapp.com/footprint/food/all'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );

  List<String> types = List<String>();
  final foodDetails = foodDetailsFromJson(response.body);
  for (int i = 0; i < foodDetails.length; i++) {
    types.add(foodDetails[i].type);
  }
  return types;
}

class QuantityTextField extends StatefulWidget {
  const QuantityTextField({Key key}) : super(key: key);

  @override
  _QuantityTextFieldState createState() => _QuantityTextFieldState();
}

class _QuantityTextFieldState extends State<QuantityTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    store.quantityController = controller;
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
