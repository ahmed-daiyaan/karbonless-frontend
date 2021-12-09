import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/History/read_activity.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyStore store = VxState.store;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: AutoSizeText(
            'Recent History',
            maxLines: 1,
            style: TextStyle(fontSize: 34, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: size.height / 2,
          width: size.width - 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20, left: 10, right: 10),
            child: Column(
              children: [
                TabBar(
                    controller: controller,
                    onTap: (index) {
                      setState(() {});
                    },
                    indicatorColor: Colors.green[900],
                    labelColor: darkGreen,
                    labelStyle: TextStyle(fontSize: 20),
                    tabs: [
                      Tab(
                        text: 'Day',
                      ),
                      Tab(
                        text: 'Week',
                      ),
                      Tab(
                        text: 'Month',
                      ),
                    ]),
                Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    'in kg of CO2',
                    style: TextStyle(color: darkGreen),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<double>>(
                      future: controller.index == 2
                          ? fetchMonthHistory()
                          : controller.index == 1
                              ? fetchWeekHistory()
                              : fetchDayHistory(),
                      builder: (context, snapshot) {
                        return BarChart(
                          BarChartData(
                              barTouchData: BarTouchData(
                                  enabled: true,
                                  handleBuiltInTouches: true,
                                  allowTouchBarBackDraw: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipPadding: EdgeInsets.all(2),
                                    tooltipMargin: 0,
                                    tooltipBgColor: Colors.transparent,
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) =>
                                            BarTooltipItem(
                                                rod.y.toString(),
                                                TextStyle(
                                                  color: darkGreen,
                                                  fontSize: 25,
                                                )),
                                  )),
                              // borderData: FlBorderData(
                              //     show: true,
                              //     border: Border ),

                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: SideTitles(showTitles: false),
                                  rightTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        TextStyle(
                                      color: darkGreen,
                                    ),
                                  ),
                                  bottomTitles: SideTitles(
                                      showTitles: true,
                                      getTitles: (value) {
                                        return value == 5
                                            ? 'Food'
                                            : value == 10
                                                ? 'Travel'
                                                : 'Products';
                                      },
                                      getTextStyles: (context, value) =>
                                          const TextStyle(
                                              color: darkGreen,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                              maxY: snapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? 50
                                  : snapshot.data.max() == 0
                                      ? 50
                                      : snapshot.data.max() +
                                          snapshot.data.max() / 10,
                              gridData: FlGridData(
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) =>
                                    FlLine(color: lightGreen, strokeWidth: 0.4),
                              ),
                              borderData: FlBorderData(show: false),
                              // borderData: FlBorderData(
                              //     show: true,
                              //     border: const Border(
                              //         top: BorderSide(color: Colors.white, width: 30),
                              //         bottom: BorderSide(color: Colors.white, width: 90),
                              //         left: BorderSide(color: Colors.white, width: 50))),
                              backgroundColor: Colors.white,
                              barGroups: [
                                BarChartGroupData(
                                    x: 5,
                                    showingTooltipIndicators: [
                                      0
                                    ],
                                    barRods: [
                                      BarChartRodData(
                                          y: snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? 0
                                              : snapshot.data[0],
                                          colors: [darkGreen],
                                          width: 30,
                                          borderRadius:
                                              BorderRadius.circular(0))
                                    ]),
                                BarChartGroupData(
                                    x: 10,
                                    showingTooltipIndicators: [
                                      0
                                    ],
                                    barRods: [
                                      BarChartRodData(
                                          y: snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? 0
                                              : snapshot.data[1],
                                          colors: [darkGreen],
                                          width: 30,
                                          borderRadius:
                                              BorderRadius.circular(0))
                                    ]),
                                BarChartGroupData(
                                    x: 15,
                                    showingTooltipIndicators: [
                                      0
                                    ],
                                    barRods: [
                                      BarChartRodData(
                                          y: snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? 0
                                              : snapshot.data[2],
                                          colors: [darkGreen],
                                          width: 30,
                                          borderRadius:
                                              BorderRadius.circular(0))
                                    ]),
                              ]),
                          swapAnimationDuration: Duration(milliseconds: 2000),
                          swapAnimationCurve: Curves.easeInOutCubicEmphasized,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder<List<ReadActivity>>(
            future: fetchHistory(controller.index == 0
                ? 'Day'
                : controller.index == 1
                    ? 'Week'
                    : 'Month'),
            builder: (context, snapshot) {
              return Expanded(
                // height: size.height / 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(

                      // itemCount: snapshot.connectionState == ConnectionState.waiting
                      //     ? 0
                      //     : snapshot.data.length,
                      children: List.generate(
                          snapshot.connectionState == ConnectionState.waiting
                              ? 0
                              : snapshot.data.length, (index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: snapshot.data[index].category == "Food"
                              ? Image.asset(
                                  'assets/images/food1.png',
                                  color: Colors.white,
                                  width: size.width / 8,
                                  height: size.width / 8,
                                )
                              : snapshot.data[index].category == "Travel"
                                  ? Image.asset(
                                      'assets/icons/car.png',
                                      color: Colors.white,
                                      width: size.width / 8,
                                      height: size.width / 8,
                                    )
                                  : Image.asset(
                                      'assets/images/cart1.png',
                                      color: Colors.white,
                                      width: size.width / 8,
                                      height: size.width / 8,
                                    ),
                          title: Text(
                            'Activity ${index + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "${snapshot.data[index].category == 'Travel' ? snapshot.data[index].distance.toString() + ' kms' : snapshot.data[index].type} "
                            " | ${roundDouble(snapshot.data[index].totalEmission, 4)} kg of Co2",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Divider(
                          color: lightGreen,
                        )
                      ],
                    );
                  })),
                ),
              );
            })
      ],
    );
  }
}

Future<List<double>> fetchDayHistory() async {
  MyStore store = VxState.store;
  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?sortBy=duration:asc&duration=currentDay'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final activity = readActivityFromJson(response.body);
  double travelTotalEmission = 0;
  double foodTotalEmission = 0;
  double productTotalEmission = 0;
  for (int i = 0; i < activity.length; i++) {
    if (activity[i].category == 'Travel')
      travelTotalEmission += activity[i].totalEmission;
    else if (activity[i].category == 'Food')
      foodTotalEmission += activity[i].totalEmission;
    else
      productTotalEmission += activity[i].totalEmission;
  }
  return [
    roundDouble(foodTotalEmission, 2),
    roundDouble(travelTotalEmission, 2),
    roundDouble(productTotalEmission, 2)
  ];
}

Future<List<double>> fetchWeekHistory() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?sortBy=duration:asc&duration=currentWeek'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final activity = readActivityFromJson(response.body);
  double travelTotalEmission = 0;
  double foodTotalEmission = 0;
  double productTotalEmission = 0;
  for (int i = 0; i < activity.length; i++) {
    if (activity[i].category == 'Travel')
      travelTotalEmission += activity[i].totalEmission;
    else if (activity[i].category == 'Food')
      foodTotalEmission += activity[i].totalEmission;
    else
      productTotalEmission += activity[i].totalEmission;
  }
  return [
    roundDouble(foodTotalEmission, 2),
    roundDouble(travelTotalEmission, 2),
    roundDouble(productTotalEmission, 2)
  ];
}

Future<List<double>> fetchMonthHistory() async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?sortBy=duration:asc&duration=currentMonth'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final activity = readActivityFromJson(response.body);
  double travelTotalEmission = 0;
  double foodTotalEmission = 0;
  double productTotalEmission = 0;
  for (int i = 0; i < activity.length; i++) {
    if (activity[i].category == 'Travel')
      travelTotalEmission += activity[i].totalEmission;
    else if (activity[i].category == 'Food')
      foodTotalEmission += activity[i].totalEmission;
    else
      productTotalEmission += activity[i].totalEmission;
  }
  return [
    roundDouble(foodTotalEmission, 2),
    roundDouble(travelTotalEmission, 2),
    roundDouble(productTotalEmission, 2)
  ];
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Future<List<ReadActivity>> fetchHistory(String time) async {
  MyStore store = VxState.store;

  var response = await http.get(
    Uri.parse(
        'https://karbonless-api.herokuapp.com/activity?sortBy=duration:asc&duration=current$time'),
    headers: <String, String>{'Authorization': 'Bearer ${store.currentToken}'},
  );
  final activity = readActivityFromJson(response.body);

  return activity;
}
