// import 'package:bit_ascol/config/const.dart';
// import 'package:flutter/material.dart';
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   final ValueChanged<int> onItemTapped;
//   final int selectedIndex;
//
//    const CustomBottomNavigationBar({
//     Key? key,
//     required this.onItemTapped,
//     required this.selectedIndex,
//   }) : super(key: key);
//
//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: primaryColor,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//         ),
//       ],
//       currentIndex: widget.selectedIndex,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.grey,
//       onTap: widget.onItemTapped,
//       type: BottomNavigationBarType.fixed,
//     );
//   }
// }
