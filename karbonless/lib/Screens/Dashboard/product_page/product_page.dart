import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/product_page/product_details.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ImagePicker _picker = ImagePicker();
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
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: size.height / 10)),
            Center(
                child: Image.asset(
              'assets/images/cart.png',
              width: size.width / 2.5,
            )),
            Padding(padding: EdgeInsets.only(top: size.height / 30)),
            const Text(
              'PRODUCTS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: size.height / 20)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90), color: lightGreen),
                child: Image.asset('assets/images/camera_icon.png',
                    width: size.width / 2)),
            Padding(padding: EdgeInsets.only(top: size.height / 10)),
            Container(
                width: size.width / 4,
                child: TextButton(
                  child: const Text(
                    "Scan",
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
                    List<String> prods = List<String>();
                    List<String> types = List<String>();
                    final XFile image = await _picker.pickImage(
                        source: ImageSource.camera, imageQuality: 50);
                    Future<List<ProductDetails>> fetchProducts() async {
                      var request = http.MultipartRequest(
                          'POST',
                          Uri.parse(
                              'https://karbonless-api.herokuapp.com/recognition/image'));
                      request.files.add(await http.MultipartFile.fromPath(
                          'input', image.path));
                      var response = await request.send();
                      var responseBody = await response.stream.bytesToString();
                      debugPrint(responseBody);
                      final productDetails =
                          productDetailsFromJson(responseBody);
                      var presponse = await http.get(
                        Uri.parse(
                            'https://karbonless-api.herokuapp.com/footprint/product/all'),
                        headers: <String, String>{
                          'Authorization': 'Bearer ${store.currentToken}'
                        },
                      );

                      final products = allProductsFromJson(presponse.body);
                      for (int i = 0; i < products.length; i++) {
                        types.add(products[i].type);
                      }
                      for (int i = 0; i < productDetails.length; i++) {
                        prods.add(productDetails[i].name);
                      }

                      return productDetails;
                    }

                    showDialog(
                        context: context,
                        builder: (context) {
                          MyStore store = VxState.store;
                          return Center(
                            child: Card(
                                color: darkGreen,
                                child: FutureBuilder<List<ProductDetails>>(
                                    future: fetchProducts(),
                                    builder: (context, snapshot) {
                                      Size size = MediaQuery.of(context).size;
                                      if (snapshot.hasError) {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                title: 'Error')
                                            .show();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                      return snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? const CircularProgressIndicator
                                              .adaptive()
                                          : snapshot.data.isNotEmpty
                                              ? Column(children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.height /
                                                              25)),
                                                  Center(
                                                      child: Image.asset(
                                                    'assets/images/cart.png',
                                                    width: size.width / 2.5,
                                                  )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.height /
                                                              30)),
                                                  const Text(
                                                    'PRODUCTS',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: size.height /
                                                              20)),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: AutoSizeText(
                                                      'Product Detected! \n \n Select from the list below or return if unfound',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(8)),
                                                  Center(
                                                    child: SizedBox(
                                                      width: size.width / 2,
                                                      child: ProductDropDown(
                                                        details: snapshot.data,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.all(
                                                          size.height / 20)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            store.fabVisibility =
                                                                true;

                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            "Go Back",
                                                            style:
                                                                const TextStyle(
                                                                    color:
                                                                        darkGreen,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ))),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Center(
                                                                    child: Card(
                                                                      color:
                                                                          darkGreen,
                                                                      child: FutureBuilder<
                                                                              ProductFootprint>(
                                                                          future: fetchProductFootprint(store
                                                                              .productValue),
                                                                          initialData: ProductFootprint(
                                                                              totalEmission:
                                                                                  0.0),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            if (snapshot.connectionState ==
                                                                                ConnectionState.waiting) {
                                                                              return const CircularProgressIndicator.adaptive();
                                                                            } else {
                                                                              return Column(children: [
                                                                                Padding(padding: EdgeInsets.all(size.width / 8)),
                                                                                const Icon(
                                                                                  Icons.done_all_rounded,
                                                                                  color: lightGreen,
                                                                                  size: 80,
                                                                                ),
                                                                                Padding(padding: EdgeInsets.all(size.width / 15)),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'The carbon emission for your recent purchase is ${snapshot.data.totalEmission} units and has been sucessfully added to your expenditure',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: const TextStyle(
                                                                                        fontSize: 25,
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(padding: EdgeInsets.all(size.width / 15)),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    store.fabVisibility = true;
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text(
                                                                                    "Done",
                                                                                    style: const TextStyle(color: darkGreen, fontSize: 30),
                                                                                  ),
                                                                                  style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                                      ))),
                                                                                )
                                                                              ]);
                                                                            }
                                                                          }),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                            "Add",
                                                            style:
                                                                const TextStyle(
                                                                    color:
                                                                        darkGreen,
                                                                    fontSize:
                                                                        30),
                                                          ),
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .white),
                                                              shape: MaterialStateProperty.all<
                                                                      RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ))),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ])
                                              : Column(
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: size.height /
                                                                25)),
                                                    Center(
                                                        child: Image.asset(
                                                      'assets/images/cart.png',
                                                      width: size.width / 2.5,
                                                    )),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: size.height /
                                                                30)),
                                                    const Text(
                                                      'PRODUCTS',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(
                                                            top: size.height /
                                                                20)),
                                                    const AutoSizeText(
                                                      'Sorry, could not detect captured product',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        store.fabVisibility =
                                                            true;

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "Go Back",
                                                        style: const TextStyle(
                                                            color: darkGreen,
                                                            fontSize: 30),
                                                      ),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colors
                                                                          .white),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ))),
                                                    )
                                                  ],
                                                );
                                    })),
                          );
                        });
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class ProductDropDown extends StatefulWidget {
  const ProductDropDown({Key key, this.details}) : super(key: key);
  final List<ProductDetails> details;
  @override
  _ProductDropDownState createState() => _ProductDropDownState();
}

class _ProductDropDownState extends State<ProductDropDown> {
  String value;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
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
        items: widget.details.map((ProductDetails value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            store.productValue = newValue;
            value = newValue;
          });
        });
  }
}

Future<ProductFootprint> fetchProductFootprint(String productValue) async {
  MyStore store = VxState.store;
  String pValue = store.productValue;
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/footprint/product?type=$pValue'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  print(response.body);
  final footprint = productFootprintFromJson(response.body);
  return footprint;
}
