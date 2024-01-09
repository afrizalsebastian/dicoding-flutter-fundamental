import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/common/navigation.dart';
import 'package:restaurant_app_fundamental_1/model/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';
import 'package:restaurant_app_fundamental_1/utils/database_helper.dart';
import 'package:restaurant_app_fundamental_1/widget/custom_scaffold.dart';

class DetailRestaurant extends StatefulWidget {
  static String routeName = "/detail_restaurant";

  final String idRestaurant;

  const DetailRestaurant(this.idRestaurant, {super.key});

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  List<String> favoriteId = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper().getFavoriteRestaurants().then((value) {
      final allId = value.map((e) => e.id).toList();
      setState(() {
        favoriteId = allId;
      });
    });
  }

  Widget _createBody(Restaurant restaurant) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag:
                      '${ApiServices.baseUrl}/images/medium/${restaurant.pictureId}',
                  child: Image.network(
                      '${ApiServices.baseUrl}/images/medium/${restaurant.pictureId}'),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: SizedBox(
                  width: 50,
                  child: Icon(
                    favoriteId.contains(restaurant.id)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Colors.red,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            restaurant.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                restaurant.city,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                restaurant.rating.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Menus',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Foods: ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Text(
                        restaurant.menus.foods[index].name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const Text(
            'Drinks: ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Text(
                        restaurant.menus.drinks[index].name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          (restaurant.customerReviews.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: restaurant.customerReviews.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                            height: 80,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Text(
                                        restaurant.customerReviews[index].name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        restaurant.customerReviews[index].date,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    restaurant.customerReviews[index].review,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : Container()),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }

  Widget _consumerData() {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, value, _) {
        if (value.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.state == ResultState.hasData) {
          final Restaurant restaurant = value.result.restaurant;

          return _createBody(restaurant);
        } else if (value.state == ResultState.error) {
          return Center(
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value.message),
                  ElevatedButton(
                    onPressed: () {
                      Navigation.intentReplacmentWithData(
                          DetailRestaurant.routeName, widget.idRestaurant);
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
      },
    );
  }

  Widget _getData() {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiServices: ApiServices(), idRestaurant: widget.idRestaurant),
      child: _consumerData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScafflod(
      body: _getData(),
    );
  }
}
