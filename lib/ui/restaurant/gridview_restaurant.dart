import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/model/restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';

class GridViewRestaurant extends StatelessWidget {
  final int gridCount;

  const GridViewRestaurant({super.key, required this.gridCount});

  List<Widget> _createGrid(BuildContext context, List<Restaurant> restaurants) {
    return List<Widget>.from(
      restaurants.map(
        (restaurant) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(DetailRestaurant.routeName, arguments: restaurant);
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
                          tag: restaurant.pictureId,
                          child: Image.network(
                            restaurant.pictureId,
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

  Widget _buildGrid(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurant(snapshot.data);

        return GridView.count(
          crossAxisCount: gridCount,
          shrinkWrap: true,
          children: _createGrid(context, restaurants),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGrid(context);
  }
}
