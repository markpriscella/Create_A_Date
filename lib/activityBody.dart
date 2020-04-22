import 'package:flutter/material.dart';
import 'package:random_date_night/activityItem.dart';
import 'package:random_date_night/dbactivity.dart';

Future<String> getRandomActivity() async {
  ActivityItem randomActivity;
  randomActivity = await DBACTIVITY.getRandomActivity();
  if(randomActivity != null) {
    return randomActivity.name;
  }
  return null;

}

class ActivityBody extends StatefulWidget {

  ActivityBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivityBodyState();
}

// FOOD SCREEN
class ActivityBodyState extends State<ActivityBody> {

  Color colorBackground = const Color.fromRGBO(57, 47, 90, 1.0);
  Color colorText = const Color.fromRGBO(240, 146, 221, 1.0);

  Color colorButton = const Color.fromRGBO(238, 200, 224, 1.0);
  Color colorButtonSplash = const Color.fromRGBO(255, 175, 240, 1.0);

  // create the list to hold Food places
  List<ActivityItem> myActivities = [];

  // temporary string to hold food names
  String tempActivity;

  List<Widget> get _listItems => myActivities.map((item) =>
      format(item)).toList();


  Widget format(ActivityItem item) {

    return Dismissible(
      key: Key(item.id.toString()),
      child: Padding(
        // add some padding for the list tiles
          padding: EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: FlatButton(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item.name, style: TextStyle(
                    color: colorText,
                    fontSize: 24.0,
                    fontFamily: 'ComicNeue',
                  )
                  ),

                ]
            ),
            onPressed: (){},

          )
      ),
      onDismissed: (DismissDirection direction) => _delete(item),
    );
  }

  Future<String> getRandomActivity() async {
    ActivityItem randomActivity;
    randomActivity = await DBACTIVITY.getRandomActivity();
    if(randomActivity != null) {
      return randomActivity.name;
    }
    return null;

  }


  // CREATE FOOD ITEM IN DB
  void _save() async {

    Navigator.of(context).pop();

    ActivityItem activitySave = ActivityItem(
      name: tempActivity,
    );

    await DBACTIVITY.insert(ActivityItem.table, activitySave);

    setState(() => tempActivity = '');

    refresh();
  } // END _save()

  void _delete(ActivityItem item) async {

    DBACTIVITY.delete(ActivityItem.table, item);
    refresh();
  } // END _delete()

  void _createFoodItem(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Create New Activity"),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop()
              ),
              FlatButton(
                  child: Text('Save'),
                  onPressed: () => _save()
              )
            ],
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Activity Name',
                  hintText: "Mini Golf"),
              onChanged: (value) { tempActivity = value; },
            ),
          );
        }
    );
  }

  @override
  void initState() {

    refresh();
    super.initState();
  }

  void refresh() async {

    List<Map<String, dynamic>> _results = await DBACTIVITY.query(ActivityItem.table);
    myActivities = _results.map((item) => ActivityItem.fromMap(item)).toList();
    setState( () {} );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: colorBackground,


        body: ListView( children: <Widget> [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
            child: Center(
              // TITLE OF THE PAGE
              child: Text('Activity List',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontFamily: 'KaushanScript',
                    color: colorText,
                  )
              ),
            ),
          ),
          Center(
            // create list view widget and populate with _listItems
              child: ListView(
                shrinkWrap: true,
                children: _listItems,)
          ),
        ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { _createFoodItem(context); },
          tooltip: 'Add a new food choice here!',
          child: Icon(Icons.library_add),
        )
    );

  }
} // FOOD SCREEN OVER