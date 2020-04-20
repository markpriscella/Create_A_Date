import 'package:flutter/material.dart';
import 'package:random_date_night/activityItem.dart';
import 'package:random_date_night/dbactivity.dart';

class FunBody extends StatefulWidget {

  FunBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FunBodyState();
}

// FOOD SCREEN
class FunBodyState extends State<FunBody> {

  TextStyle _style = TextStyle(color: Colors.black, fontSize: 24);


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
                  Text(item.name, style: _style),

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
        body: Center(
            child: ListView( children: _listItems )

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { _createFoodItem(context); },
          tooltip: 'Add a new food choice here!',
          child: Icon(Icons.library_add),
        )
    );

  }
} // FOOD SCREEN OVER