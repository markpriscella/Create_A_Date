import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:random_date_night/food.dart';
import 'package:random_date_night/FoodItem.dart';


abstract class DBFOOD {

  static Database _dbfood;

  static int get _version => 1;

  static Future<void> init() async {

    if (_dbfood != null) { return _dbfood; }

    try {
      String _path = await getDatabasesPath() + 'food';
      _dbfood = await openDatabase(_path, version: _version, onCreate: onCreate);
    }
    catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async =>
      await db.execute("CREATE TABLE food_items (id INTEGER PRIMARY KEY NOT NULL, name TEXT)",);

  static Future<List<Map<String, dynamic>>> query(String table) async => _dbfood.query(table);

  static Future<int> insert(String table, Food food) async =>
      await _dbfood.insert(table, food.toMap());

  static Future<int> update(String table, Food food) async =>
      await _dbfood.update(table, food.toMap(), where: 'id = ?', whereArgs: [food.id]);

  static Future<int> delete(String table, Food item) async =>
      await _dbfood.delete(table, where: 'id = ?', whereArgs: [item.id]);

  static Future<FoodItem> getRandFood() async {

    List<Map> randFoodMap =
    await _dbfood.rawQuery('SELECT * FROM food_items ORDER BY RANDOM() LIMIT 1');

    if (randFoodMap.length > 0)
    {
      return FoodItem.fromMap(randFoodMap.first);
    }
    return null;

  }
}

