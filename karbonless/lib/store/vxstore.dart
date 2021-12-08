import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/store/travel_footprint.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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
  String userId;

  TextEditingController quantityController;
  String productValue;
  TimeOfDay breakfastTime;
  TimeOfDay lunchTime;
  TimeOfDay dinnerTime;
  FlutterLocalNotificationsPlugin plugin;
  String currentToken;
  String currentUser;

  void insertTravel() async {
    travelValues.distance = int.parse(distanceController.value.text);
  }

  void insertFood() {
    foodValues.quantity = int.parse(quantityController.value.text);
  }

  void setNotificationTimes() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Calcutta'));
    await plugin.zonedSchedule(
        0,
        'Time for Breakfast',
        'Add your breakfast to calculate carboon footprint',
        _nextInstanceOfTime(breakfastTime.hour, breakfastTime.minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('1', 'Karbonize',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'Food');
    await plugin.zonedSchedule(
        0,
        'Time for Lunch',
        'Add your Lunch to calculate carboon footprint',
        _nextInstanceOfTime(lunchTime.hour, lunchTime.minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('1', 'Karbonize',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'Food');
    await plugin.zonedSchedule(
        0,
        'Time for Dinner',
        'Add your Dinner to calculate carboon footprint',
        _nextInstanceOfTime(dinnerTime.hour, dinnerTime.minute),
        const NotificationDetails(
          android: AndroidNotificationDetails('1', 'Karbonize',
              channelDescription: 'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'Food');
  }
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
