import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:random_date_night/food.dart';
import 'package:random_date_night/FoodItem.dart';
import 'package:path/path.dart' as p;


abstract class DBFOOD {

  static Database _dbfood;

  static int get _version => 1;

  static Future<Database> init() async {
    //Get path of the directory for android and iOS.

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'food.db');

    //open/create database at a given path
    _dbfood = await openDatabase(path, version: 1, onCreate: onCreate);

    return _dbfood;

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

