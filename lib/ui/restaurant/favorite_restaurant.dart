import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/provider/db_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/consumer_type.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/gridview_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/listview_restaurant.dart';

class FavoriteRestaurant extends StatelessWidget {
  static String pageName = 'Favorite';

  const FavoriteRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final DbProvider databaseProvider = DbProvider();
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
                'Favorite Restaurant',
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
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return ChangeNotifierProvider(
                  create: (_) => databaseProvider,
                  child: const ListViewRestaurant(
                      typeList: ConsumerTypeList.favorite),
                );
              } else if (constraints.maxWidth < 900) {
                return ChangeNotifierProvider(
                  create: (_) => databaseProvider,
                  child: const GridViewRestaurant(
                      gridCount: 3, typeList: ConsumerTypeList.favorite),
                );
              } else {
                return ChangeNotifierProvider(
                  create: (_) => databaseProvider,
                  child: const GridViewRestaurant(
                      gridCount: 5, typeList: ConsumerTypeList.favorite),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
