import 'package:animated_background/animated_background.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/iconHierarchy.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class Badges extends StatefulWidget {
  const Badges({Key key}) : super(key: key);

  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      MyStore store = VxState.store;
      Size size = MediaQuery.of(context).size;
      if (store.oldBadgeCount < store.no_of_badges) {
        await AwesomeDialog(
          btnOkColor: Colors.white,
          buttonsTextStyle: const TextStyle(color: darkGreen),
          dialogBackgroundColor: lightGreen,
          borderSide: const BorderSide(
              width: 7, color: Color.fromRGBO(251, 205, 38, 1)),
          customHeader: IconHierarchy().badges[store.no_of_badges],
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: Column(
              children: const [
                Text(
                  'CONGRATULATIONS!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text(
                  'You have unlocked a new badge!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text(
                  'Keep earning badges to unlock the constellation',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          title: 'CONGRATULATIONS',
          desc: 'You have unlocked a new badge!',
          btnOkOnPress: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setInt('badgeCount', store.no_of_badges);
          },
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        child: PageView(
            scrollDirection: Axis.vertical,
            children: const [Constellation1(), Constellation2()]),
        vsync: this,
        behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
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

class _Constellation1State extends State<Constellation1> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    var max = store.no_of_badges;
    if (store.no_of_badges > 5) max = 5;
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Padding(padding: EdgeInsets.all(size.height / 20)),
      const Text('URSA MINOR',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
      Padding(padding: EdgeInsets.all(size.height / 24)),
      max != 0
          ? Image.asset(
              'assets/badges/b$max.png',
              height: size.height / 2,
            )
          : Image.asset(
              'assets/badges/shape1.png',
              height: size.height / 2,
            ),
      const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.white,
          size: 50,
        ),
      ),
      // Stack(alignment: Alignment.topLeft, children: createC1Children(size))
    ]);
  }
}

class Constellation2 extends StatefulWidget {
  const Constellation2({Key key}) : super(key: key);

  @override
  _Constellation2State createState() => _Constellation2State();
}

class _Constellation2State extends State<Constellation2> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    var max = store.no_of_badges;
    if (store.no_of_badges > 10) max = 10;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Icon(
            Icons.arrow_drop_up_sharp,
            color: Colors.white,
            size: 50,
          ),
        ),
        Padding(padding: EdgeInsets.all(size.height / 38)),
        const Text('CASSIOPEIA',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.all(size.height / 24)),
        max > 5
            ? Image.asset(
                'assets/badges/b$max.png',
                height: size.height / 2,
              )
            : Image.asset('assets/badges/shape2.png', height: size.height / 2)
      ],
    );
  }
}
