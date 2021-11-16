// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int activeIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBottomNavigationBar(
//         iconSize: 28,
//         onTap: (newIndex) {
//           setState(() {
//             activeIndex = newIndex;
//           });
//         },
//         // gapWidth: 20,
//         activeIndex: activeIndex,
//         gapLocation: GapLocation.center,
//         activeColor: Color.fromRGBO(24, 57, 43, 1),
//         inactiveColor: Colors.grey,
//         icons: <IconData>[
//           Icons.home_outlined,
//           Icons.sticky_note_2_outlined,
//           Icons.star_border_purple500_outlined,
//           Icons.account_circle_outlined
//         ]);
//   }
// }
// Container(
        //   height: 60,
        //   width: 60,
        //   child: CircularMenu(
        //     toggleButtonOnPressed: () {
        //       print("tp");
        //     },
        //     alignment: Alignment.center,
        //     startingAngleInRadian: 3.49,
        //     endingAngleInRadian: 5.93,
        //     toggleButtonPadding: 0,
        //     toggleButtonMargin: 0,
        //     toggleButtonSize: 60,
        //     toggleButtonBoxShadow: [],
        //     toggleButtonIconColor: Color.fromRGBO(24, 57, 43, 1),
        //     toggleButtonAnimatedIconData: AnimatedIcons.add_event,
        //     items: [
        //       CircularMenuItem(
        //         onTap: () {
        //           print("tapped");
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => TravelPage()));
        //         },
        //         icon: Icons.train_outlined,
        //         iconColor: Color.fromRGBO(24, 57, 43, 1),
        //         iconSize: 38,
        //         padding: 5,
        //         margin: 0,
        //       ),
        //       CircularMenuItem(
        //         onTap: () {
        //           print("tapped");
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => TravelPage()));
        //         },
        //         icon: Icons.food_bank_outlined,
        //         iconColor: Color.fromRGBO(24, 57, 43, 1),
        //         iconSize: 40,
        //         padding: 8,
        //         margin: 0,
        //       ),
        //       CircularMenuItem(
        //         onTap: () {
        //           print("tapped");
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => TravelPage()));
        //         },
        //         icon: Icons.shopping_cart_outlined,
        //         iconColor: Color.fromRGBO(24, 57, 43, 1),
        //         iconSize: 38,
        //         padding: 5,
        //         margin: 0,
        //       ),
        //     ],
        //   ),
        // ),

