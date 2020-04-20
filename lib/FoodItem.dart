import 'package:random_date_night/food.dart';

class FoodItem extends Food {

  static String table = 'food_items';

  int id;

  String name;

  FoodItem({this.id, this.name});

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'name': name
    };

    if (id != null) { map['id'] = id; }

    return map;
  }

  static FoodItem fromMap(Map<String, dynamic> map) {

    return FoodItem(
        id: map['id'],
        name: map['name']
    );
  }
}