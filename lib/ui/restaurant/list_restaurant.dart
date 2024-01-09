import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/consumer_type.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/gridview_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/listview_restaurant.dart';

class ListRestaurant extends StatelessWidget {
  static String pageName = "Restaurants";

  const ListRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final ListRestaurantProvider listRestaurantProvider =
        ListRestaurantProvider(
      apiServices: ApiServices(),
    );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 125,
              pinned: true,
              backgroundColor: Colors.blue,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(color: Colors.lightBlue),
                    const Positioned(
                      bottom: 5,
                      right: 15,
                      child: Text(
                        'Recomendation restaurant for you!',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                title: const Text(
                  'Restaurant',
                  style: TextStyle(fontSize: 18),
                ),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            ),
          ];
        },
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return ChangeNotifierProvider(
                create: (_) => listRestaurantProvider,
                child:
                    const ListViewRestaurant(typeList: ConsumerTypeList.list),
              );
            } else if (constraints.maxWidth < 900) {
              return ChangeNotifierProvider(
                create: (_) => listRestaurantProvider,
                child: const GridViewRestaurant(
                    gridCount: 3, typeList: ConsumerTypeList.list),
              );
            } else {
              return ChangeNotifierProvider(
                create: (_) => listRestaurantProvider,
                child: const GridViewRestaurant(
                    gridCount: 5, typeList: ConsumerTypeList.list),
              );
            }
          },
        ),
      ),
    );
  }
}
