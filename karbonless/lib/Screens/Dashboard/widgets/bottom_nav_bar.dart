import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Dashboard/food_page/food_page.dart';
import 'package:flutter_auth/Screens/Dashboard/product_page/product_page.dart';
import 'package:flutter_auth/Screens/Dashboard/travel_page/travel_page.dart';
import 'package:flutter_auth/Screens/Dashboard/widgets/fab_bar.dart';
import 'package:flutter_auth/Screens/Dashboard/widgets/overlay.dart';

import 'package:flutter_auth/store/vxstore.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    return FABBottomAppBar(
      color: Colors.grey,
      selectedColor: Color.fromRGBO(88, 139, 118, 1),
      onTabSelected: (selectedIndex) {
        store.pageController.animateToPage(selectedIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceIn);
      },
      notchedShape: CircularNotchedRectangle(),
      items: [
        FABBottomAppBarItem(
          iconData: Icons.home_outlined,
          text: 'Home',
        ),
        FABBottomAppBarItem(
          iconData: Icons.receipt_outlined,
          text: 'History',
        ),
        FABBottomAppBarItem(
          iconData: Icons.star_border_purple500_outlined,
          text: 'Badges',
        ),
        FABBottomAppBarItem(
          iconData: Icons.account_circle_outlined,
          text: 'Profile',
        )
      ],
    );
  }
}

class FabBuilder extends StatefulWidget {
  const FabBuilder({Key key}) : super(key: key);

  @override
  _FabBuilderState createState() => _FabBuilderState();
}

class _FabBuilderState extends State<FabBuilder> {
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    final icons = [
      Icons.train_outlined,
      Icons.food_bank_outlined,
      Icons.shopping_cart_outlined
    ];
    return AnchoredOverlay(
      showOverlay: store.fabVisibility,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (int value) {
              if (value == 0) {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TravelPage()))
                    .then((_) {
                  setState(() {});
                });
              } else if (value == 1) {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FoodPage()))
                    .then((_) {
                  setState(() {});
                });
              } else if (value == 2) {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductPage()))
                    .then((_) {
                  setState(() {});
                });
              }
              MyStore store = VxState.store;
              store.fabVisibility = false;
              setState(() {});
            },
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        foregroundColor: Color.fromRGBO(88, 139, 118, 1),
        tooltip: 'Add Event',
        child: Icon(
          Icons.safety_divider,
          color: Color.fromRGBO(88, 139, 118, 1),
        ),
        elevation: 2.0,
      ),
    );
  }
}

Widget buildFab(BuildContext context) {}
