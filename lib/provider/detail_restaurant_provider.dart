import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/model/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/provider/restaurant_enum.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final String idRestaurant;

  DetailRestaurantProvider(
      {required this.apiServices, required this.idRestaurant}) {
    _fetchData();
  }

  late DetailDataRestaurant _detailDataRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailDataRestaurant get result => _detailDataRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant =
          await apiServices.getDetailRestaurant(idRestaurant);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'There is no restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailDataRestaurant = detailRestaurant;
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
