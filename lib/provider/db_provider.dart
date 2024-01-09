import 'package:flutter/foundation.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/utils/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _favoriteRestaurant = [];
  late DatabaseHelper _dbHelper;

  List<Restaurant> get favoriteRestaurant => _favoriteRestaurant;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavoriteRestaurant();
  }

  void _getAllFavoriteRestaurant() async {
    _favoriteRestaurant = await _dbHelper.getFavoriteRestaurants();
    notifyListeners();
  }

  Future<void> addFavoriteRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertFavoriteRestaurant(restaurant);
    _getAllFavoriteRestaurant();
  }

  void deleteFavorite(String id) async {
    _dbHelper.deleteFavoriteRestaurant(id);
    _getAllFavoriteRestaurant();
  }
}
