import 'package:flutter/material.dart';

class Positions {
  Positions(double x, double y) {
    this.x = x;
    this.y = y;
  }
  double x;
  double y;
}

class IconHierarchy {
  List<Positions> badgePosition = [
    Positions(103, 63.5),
    Positions(114, 176),
    Positions(-5, 245),
    Positions(60, 338),
    Positions(176, 295),
    Positions(60, 43),
    Positions(-5, 123),
    Positions(113, 180),
    Positions(-5, 255),
    Positions(103, 337),
  ];
  List<Image> badges = [
    Image.asset('assets/images/cup-01.png'),
    Image.asset('assets/images/cloud-01.png'),
    Image.asset('assets/images/ribbon-01.png'),
    Image.asset('assets/images/Hand-01.png'),
    Image.asset('assets/images/star-01.png'),
    Image.asset('assets/images/sun-01.png'),
    Image.asset('assets/images/rainbow-01.png'),
    Image.asset('assets/images/flower-01.png'),
    Image.asset('assets/images/plant-01.png'),
    Image.asset('assets/images/bear-01.png'),
  ];
}
