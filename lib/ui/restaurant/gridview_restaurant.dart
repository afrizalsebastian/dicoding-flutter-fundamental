import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/list_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';
import 'package:restaurant_app_fundamental_1/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/homepage/home_page.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/consumer_type.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';

class GridViewRestaurant extends StatelessWidget {
  final ConsumerTypeList typeList;
  final int gridCount;

  const GridViewRestaurant(
      {super.key, required this.gridCount, required this.typeList});

  List<Widget> _createGrid(BuildContext context, List<Restaurant> restaurants) {
    return List<Widget>.from(
      restaurants.map(
        (restaurant) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(DetailRestaurant.routeName,
                  arguments: restaurant.id);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag:
                              '${ApiServices.baseUrl}/images/medium/${restaurant.pictureId}',
                          child: Image.network(
                            '${ApiServices.baseUrl}/images/medium/${restaurant.pictureId}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant.city,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rate_rounded,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.rating.toString(),
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, value) {
    if (value.state == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (value.state == ResultState.hasData) {
      final List<Restaurant> restaurants = value.result.restaurants;

      return GridView.count(
        crossAxisCount: gridCount,
        shrinkWrap: true,
        children: _createGrid(context, restaurants),
      );
    } else if (value.state == ResultState.error) {
      return Center(
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value.message),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Reload',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: Material(
          child: Text(''),
        ),
      );
    }
  }

  Widget _consumerGrid(BuildContext context, ConsumerTypeList typeConsumer) {
    if (typeConsumer == ConsumerTypeList.list) {
      return Consumer<ListRestaurantProvider>(
        builder: (context, value, _) {
          return _buildGrid(context, value);
        },
      );
    } else {
      return Consumer<SearchRestaurantProvider>(
        builder: (context, value, _) {
          return _buildGrid(context, value);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _consumerGrid(context, typeList);
  }
}
