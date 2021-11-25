import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/store/iconHierarchy.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';

class Badges extends StatefulWidget {
  const Badges({Key key}) : super(key: key);

  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        child: PageView(
            scrollDirection: Axis.vertical,
            children: [Constellation1(), Constellation2()]),
        vsync: this,
        behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
                spawnMaxSpeed: 100,
                spawnMinSpeed: 10,
                baseColor: Colors.white)));
  }
}

class Constellation1 extends StatefulWidget {
  const Constellation1({Key key}) : super(key: key);

  @override
  _Constellation1State createState() => _Constellation1State();
}

List<Widget> createC1Children(Size size) {
  MyStore store = VxState.store;
  List<Widget> children = List<Widget>();
  children.add(Image.asset(
    'assets/images/shape1.png',
    height: size.height / 2,
  ));
  var max = store.no_of_badges;
  if (store.no_of_badges > 5) max = 5;
  for (int i = 0; i < max; i++) {
    children.add(Positioned(
        top: IconHierarchy().badgePosition[i].y,
        left: IconHierarchy().badgePosition[i].x,
        child: Container(
            height: 80, width: 80, child: IconHierarchy().badges[i])));
  }

  children.add(Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Icon(
      Icons.arrow_drop_down_sharp,
      color: Colors.white,
      size: 50,
    ),
  ));
  return children;
}

class _Constellation1State extends State<Constellation1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Padding(padding: EdgeInsets.all(size.height / 20)),
      Text('URSA MINOR',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      Padding(padding: EdgeInsets.all(size.height / 24)),
      Stack(alignment: Alignment.topLeft, children: createC1Children(size))
    ]);
  }
}

List<Widget> createC2Children(Size size) {
  MyStore store = VxState.store;
  List<Widget> children = List<Widget>();
  children.add(Image.asset(
    'assets/images/shape2.png',
    height: size.height / 2,
  ));
  var max = store.no_of_badges;
  max = 10;
  if (max - 5 > 0) {
    // if (store.no_of_badges > 10) max = 5;
    for (int i = 5; i < max; i++) {
      children.add(Positioned(
          top: IconHierarchy().badgePosition[i].y,
          left: IconHierarchy().badgePosition[i].x,
          child: Container(
              height: 80, width: 80, child: IconHierarchy().badges[i])));
    }
  }

  return children;
}

class Constellation2 extends StatefulWidget {
  const Constellation2({Key key}) : super(key: key);

  @override
  _Constellation2State createState() => _Constellation2State();
}

class _Constellation2State extends State<Constellation2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Icon(
            Icons.arrow_drop_up_sharp,
            color: Colors.white,
            size: 50,
          ),
        ),
        Padding(padding: EdgeInsets.all(size.height / 38)),
        Text('CASSIOPEIA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.all(size.height / 24)),
        Stack(children: createC2Children(size))
      ],
    );
  }
}
