import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/model/restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/list_restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ListRestaurant.routeName,
      routes: {
        ListRestaurant.routeName: (context) => const ListRestaurant(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(
            ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}
