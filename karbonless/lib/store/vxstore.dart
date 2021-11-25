import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/store/travel_footprint.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  PageController pageController;
  bool fabVisibility = true;
  Future<TravelFootprint> travelFootprint;
  int no_of_badges;
  final travelValues = InsertTravelValues();
  TextEditingController distanceController;

  void insertTravel() async {
    travelValues.distance = int.parse(distanceController.value.text);
  }
}
