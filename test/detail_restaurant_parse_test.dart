import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_fundamental_1/model/detail_restaurant.dart';

void main() {
  group('Parse detail Item Restaurant', () {
    final detailItemRestaurant = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "city": "Medan",
      "address": "Jln. Pandeglang no 19",
      "pictureId": "14",
      "categories": [
        {"name": "Italia"},
        {"name": "Modern"}
      ],
      "menus": {
        "foods": [
          {"name": "Paket rosemary"},
          {"name": "Toastie salmon"},
          {"name": "Bebek crepes"},
          {"name": "Salad lengkeng"}
        ],
        "drinks": [
          {"name": "Es krim"},
          {"name": "Sirup"},
          {"name": "Jus apel"},
          {"name": "Jus jeruk"},
          {"name": "Coklat panas"},
          {"name": "Air"},
          {"name": "Es kopi"},
          {"name": "Jus alpukat"},
          {"name": "Jus mangga"},
          {"name": "Teh manis"},
          {"name": "Kopi espresso"},
          {"name": "Minuman soda"},
          {"name": "Jus tomat"}
        ]
      },
      "rating": 4.2,
      "customerReviews": [
        {
          "name": "Ahmad",
          "review": "Tidak rekomendasi untuk pelajar!",
          "date": "13 November 2019"
        },
        {"name": "Anonim", "review": "asdasd", "date": "9 Januari 2024"},
        {"name": "asdasd", "review": "dsadasd", "date": "9 Januari 2024"},
        {"name": "Dicoding", "review": "sip", "date": "9 Januari 2024"},
        {"name": "qqqqqqqq", "review": "qqqqqqqqq", "date": "9 Januari 2024"}
      ]
    };

    test('id detail Item Restaurant', () {
      final result = Restaurant.fromJson(detailItemRestaurant);
      expect(result.id, detailItemRestaurant['id']);
    });
  });
}
