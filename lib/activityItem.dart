import 'package:random_date_night/activity.dart';

class ActivityItem extends Activity {

  static String table = 'activity_items';

  int id;

  String name;

  ActivityItem({this.id, this.name});

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'name': name
    };

    if (id != null) { map['id'] = id; }

    return map;
  }

  static ActivityItem fromMap(Map<String, dynamic> map) {

    return ActivityItem(
        id: map['id'],
        name: map['name']
    );
  }
}