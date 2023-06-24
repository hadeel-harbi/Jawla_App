import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import '../profile_screens/profile_screen.dart';
import 'plan_screen.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key, required this.screenIndex})
      : super(key: key);
  final int screenIndex;

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const PlanScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.screenIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFFE3E0D9),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Plan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
