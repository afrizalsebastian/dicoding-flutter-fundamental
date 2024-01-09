import 'package:path/path.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableFavoriteRestaurant = 'favorite_restaurant';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavoriteRestaurant (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
          )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavoriteRestaurant, restaurant.toJson());
    print('Data Saved');
  }

  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> dbResults =
        await db.query(_tableFavoriteRestaurant);

    return dbResults.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<void> deleteFavoriteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
