import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/store/travel_footprint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import 'food_footprint.dart';

class MyStore extends VxStore {
  PageController pageController;
  bool fabVisibility = true;
  Future<TravelFootprint> travelFootprint;
  int no_of_badges;
  int oldBadgeCount;
  final travelValues = InsertTravelValues();
  final foodValues = InsertFoodValues();
  TextEditingController distanceController;
  TextEditingController quantityController;

  void insertTravel() async {
    travelValues.distance = int.parse(distanceController.value.text);
  }

  void insertFood() {
    foodValues.quantity = int.parse(quantityController.value.text);
  }
}
