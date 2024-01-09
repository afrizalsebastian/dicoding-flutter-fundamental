import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/search_restaurant.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<Widget> _listPage = [
    const ListRestaurant(),
    const SearchRestaurant(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.restaurant),
      label: ListRestaurant.pageName,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.search),
      label: SearchRestaurant.pageName,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        selectedItemColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
