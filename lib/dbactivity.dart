import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:random_date_night/activity.dart';
import 'package:random_date_night/activityItem.dart';
import 'package:path/path.dart' as p;


// database class
abstract class DBACTIVITY {

  static Database _dbactivity;

  static int get _version => 1;

  static Future<Database> init() async {
    //Get path of the directory for android and iOS.

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'activity.db');

    //open/create database at a given path
    _dbactivity = await openDatabase(path, version: 1, onCreate: onCreate);

    return _dbactivity;

  }

  static void onCreate(Database db, int version) async =>
      await db.execute("CREATE TABLE activity_items "
          "(id INTEGER PRIMARY KEY NOT NULL, name TEXT)",);

  static Future<List<Map<String, dynamic>>>
  query(String table) async => _dbactivity.query(table);

  static Future<int> insert(String table, Activity activity) async =>
      await _dbactivity.insert(table, activity.toMap());

  static Future<int> update(String table, Activity activity) async =>
      await _dbactivity.update
        (table, activity.toMap(), where: 'id = ?', whereArgs: [activity.id]);

  static Future<int> delete(String table, Activity item) async =>
      await _dbactivity.delete(table, where: 'id = ?', whereArgs: [item.id]);

  static Future<ActivityItem> getRandomActivity() async {

    List<Map> randActivityMap =
    await _dbactivity.rawQuery
      ('SELECT * FROM activity_items ORDER BY RANDOM() LIMIT 1');

    if (randActivityMap.length > 0)
    {
      return ActivityItem.fromMap(randActivityMap.first);
    }
    return null;

  }

}

