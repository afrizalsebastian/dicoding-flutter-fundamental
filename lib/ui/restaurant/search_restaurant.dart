import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/consumer_type.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/gridview_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/listview_restaurant.dart';

class SearchRestaurant extends StatefulWidget {
  static String pageName = 'Search';
  const SearchRestaurant({super.key});

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final SearchRestaurantProvider searchRestaurantProvider =
      SearchRestaurantProvider(apiServices: ApiServices());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.blue,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Search Restaurant',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: TextField(
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              focusColor: Colors.blue,
              prefixIcon: const Icon(
                Icons.search,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: const BorderSide(width: 2.0, color: Colors.blue),
              ),
            ),
            onChanged: (value) {
              searchRestaurantProvider.updateQuery(value);
            },
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return ChangeNotifierProvider(
                  create: (_) => searchRestaurantProvider,
                  child: const ListViewRestaurant(
                    typeList: ConsumerTypeList.search,
                  ),
                );
              } else if (constraints.maxWidth < 900) {
                return ChangeNotifierProvider(
                  create: (_) => searchRestaurantProvider,
                  child: const GridViewRestaurant(
                    gridCount: 3,
                    typeList: ConsumerTypeList.search,
                  ),
                );
              } else {
                return ChangeNotifierProvider(
                  create: (_) => searchRestaurantProvider,
                  child: const GridViewRestaurant(
                    gridCount: 5,
                    typeList: ConsumerTypeList.search,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
