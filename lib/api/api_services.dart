import 'package:restaurant_app_fundamental_1/model/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_fundamental_1/model/search_restaurant.dart';

class ApiServices {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<ListDataRestaurant> getListRestaurant() async {
    Uri url = Uri.parse("$baseUrl/list");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return listDataRestaurantFromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  Future<DetailDataRestaurant> getDetailRestaurant(String idRestaurnt) async {
    Uri url = Uri.parse("$baseUrl/detail/$idRestaurnt");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return detailDataRestaurantFromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }

  Future<SearchDataRestaurant> getSearchRestaurant(String? query) async {
    final String finalQuery = query ?? "";
    Uri url = Uri.parse("$baseUrl/search?q=$finalQuery");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return searchDataRestaurantFromJson(response.body);
    } else {
      throw Exception('Fail to load data');
    }
  }
}
