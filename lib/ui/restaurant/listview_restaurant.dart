import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/common/navigation.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/db_provider.dart';
import 'package:restaurant_app_fundamental_1/provider/list_restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';
import 'package:restaurant_app_fundamental_1/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/homepage/home_page.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/consumer_type.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/utils/database_helper.dart';

class ListViewRestaurant extends StatefulWidget {
  final ConsumerTypeList typeList;

  const ListViewRestaurant({super.key, required this.typeList});

  @override
  State<ListViewRestaurant> createState() => _ListViewRestaurantState();
}

class _ListViewRestaurantState extends State<ListViewRestaurant> {
  Widget _createList(
      BuildContext context, Restaurant restaurant, ConsumerTypeList typeList) {
    return GestureDetector(
      onTap: () {
        Navigation.intentWithData(DetailRestaurant.routeName, restaurant.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        height: 100,
        child: Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final listFavoriteId =
                    Provider.of<DbProvider>(context, listen: false)
                        .favoriteRestaurant
                        .map((e) => e.id)
                        .toList();

                if (listFavoriteId.contains(restaurant.id)) {
                  Provider.of<DbProvider>(context, listen: false)
                      .deleteFavorite(restaurant.id);
                } else {
                  Provider.of<DbProvider>(context, listen: false)
                      .addFavoriteRestaurant(restaurant);
                }
              },
              child: SizedBox(
                width: 50,
                child: Icon(
                  Provider.of<DbProvider>(context, listen: true)
                          .favoriteRestaurant
                          .map((e) => e.id)
                          .toList()
                          .contains(restaurant.id)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(context, value, ConsumerTypeList typeConsumer) {
    if (typeConsumer == ConsumerTypeList.favorite) {
      List<Restaurant> restaurants = value.favoriteRestaurant;
      return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return _createList(context, restaurants[index], typeConsumer);
        },
      );
    } else {
      if (value.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (value.state == ResultState.hasData) {
        List<Restaurant> restaurants = value.result.restaurants;

        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _createList(context, restaurants[index], typeConsumer);
          },
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
                    Navigation.intentReplacment(HomePage.routeName);
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
  }

  Widget _consumerList(BuildContext context, ConsumerTypeList typeConsumer) {
    if (typeConsumer == ConsumerTypeList.search) {
      return Consumer<SearchRestaurantProvider>(
        builder: (context, value, _) {
          return _buildList(context, value, typeConsumer);
        },
      );
    } else if (typeConsumer == ConsumerTypeList.list) {
      return Consumer<ListRestaurantProvider>(
        builder: (context, value, _) {
          return _buildList(context, value, typeConsumer);
        },
      );
    } else {
      return Consumer<DbProvider>(
        builder: (context, value, _) {
          return _buildList(context, value, typeConsumer);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _consumerList(context, widget.typeList);
  }
}
