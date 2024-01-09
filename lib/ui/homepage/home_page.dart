import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/common/navigation.dart';
import 'package:restaurant_app_fundamental_1/provider/db_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/favorite_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/search_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/settings/settings_page.dart';
import 'package:restaurant_app_fundamental_1/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listPage = [
    ChangeNotifierProvider<DbProvider>(
      create: (_) => DbProvider(),
      child: Consumer<DbProvider>(
        builder: (context, value, child) {
          return const ListRestaurant();
        },
      ),
    ),
    const FavoriteRestaurant(),
    ChangeNotifierProvider<DbProvider>(
      create: (_) => DbProvider(),
      child: Consumer<DbProvider>(
        builder: (context, value, child) {
          return const SearchRestaurant();
        },
      ),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.restaurant),
      label: ListRestaurant.pageName,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.favorite),
      label: FavoriteRestaurant.pageName,
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
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestaurant.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.intentWoData(SettingsPage.routeName);
        },
        tooltip: 'Settings',
        backgroundColor: Colors.blue,
        mini: true,
        child: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }
}
