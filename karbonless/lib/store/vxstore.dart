import 'dart:convert';

import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class MyStore extends VxStore {
  bool fabVisibility = true;
  void insertTravel() {
    InsertTravel();
  }
}

class InsertTravel extends VxMutation<MyStore> {
  Future<void> perform() async {
    var response = await http.get(
      Uri.parse(
          'https://karbonless-api.herokuapp.com/travel?type=Two Wheelers, Scooter&mode=Land&distance=3'),
      headers: <String, String>{
        'Bearer':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTkzZjg1MTBlZmQ0MTAwMTY4ZDMzZjYiLCJpYXQiOjE2MzcyMzE4NDZ9.mUr1j8NLn3tu_pszz7xSqlXAPY4JDFXREpsboYZxpm0'
      },
    );
    print(response.body);
  }
}
