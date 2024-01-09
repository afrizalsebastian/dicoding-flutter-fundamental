import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/model/search_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;
  String? query;

  SearchRestaurantProvider({required this.apiServices, this.query}) {
    _fetchData();
  }

  late SearchDataRestaurant _searchDataRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchDataRestaurant get result => _searchDataRestaurant;

  ResultState get state => _state;

  void updateQuery(String newQuery) {
    query = newQuery;
    _fetchData();
    notifyListeners();
  }

  Future<dynamic> _fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await apiServices.getSearchRestaurant(query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'There is no restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchDataRestaurant = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e is SocketException) {
        return _message = 'No Internet Connection';
      } else {
        return _message = 'Error: $e';
      }
    }
  }
}
