import 'dart:convert';

class FoodsAndDrinks {
  final String name;

  FoodsAndDrinks({required this.name});

  factory FoodsAndDrinks.fromJson(Map<String, dynamic> json) => FoodsAndDrinks(
        name: json['name'],
      );
}

class Menus {
  final List<FoodsAndDrinks> foods;
  final List<FoodsAndDrinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<FoodsAndDrinks>.from(
          json['foods'].map(
            (food) => FoodsAndDrinks.fromJson(food),
          ),
        ),
        drinks: List<FoodsAndDrinks>.from(
          json['drinks'].map(
            (drink) => FoodsAndDrinks.fromJson(drink),
          ),
        ),
      );
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'] * 1.0,
        menus: Menus.fromJson(json['menus']),
      );
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);

  return List<Restaurant>.from(
    parsed['restaurants'].map(
      (restaurant) => Restaurant.fromJson(restaurant),
    ),
  );
}
