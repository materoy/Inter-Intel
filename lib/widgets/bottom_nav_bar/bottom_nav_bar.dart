import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
    );
  }

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
    BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
    BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
    BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
  ];
}
