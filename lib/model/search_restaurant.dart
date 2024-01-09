import 'dart:convert';

import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';

SearchDataRestaurant searchDataRestaurantFromJson(String str) =>
    SearchDataRestaurant.fromJson(json.decode(str));

String searchDataRestaurantToJson(SearchDataRestaurant data) =>
    json.encode(data.toJson());

class SearchDataRestaurant {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchDataRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchDataRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchDataRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
