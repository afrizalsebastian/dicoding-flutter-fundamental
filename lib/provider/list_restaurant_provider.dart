import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;

  ListRestaurantProvider({required this.apiServices}) {
    _fetchData();
  }

  late ListDataRestaurant _listDataRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListDataRestaurant get result => _listDataRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurant = await apiServices.getListRestaurant();
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'There is no restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listDataRestaurant = listRestaurant;
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
