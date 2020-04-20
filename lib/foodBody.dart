import 'package:flutter/material.dart';
import 'package:random_date_night/FoodItem.dart';
import 'package:random_date_night/dbfood.dart';
import "dart:math";

class FoodBody extends StatefulWidget {

  FoodBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoodBodyState();
}

// FOOD SCREEN
class FoodBodyState extends State<FoodBody> {

  TextStyle _style = TextStyle(color: Colors.black, fontSize: 24);


  // create the list to hold Food places
  List<FoodItem> myFoods = [];

  // temporary string to hold food names
  String tempFood;

  List<Widget> get _listItems => myFoods.map((item) => format(item)).toList();


  Widget format(FoodItem item) {

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


  // CREATE FOOD ITEM IN DB
  void _save() async {

    Navigator.of(context).pop();

    FoodItem foodSave = FoodItem(
      name: tempFood,
    );
    
    await DBFOOD.insert(FoodItem.table, foodSave);

    setState(() => tempFood = '');

    refresh();
  } // END _save()

  void _delete(FoodItem item) async {

    DBFOOD.delete(FoodItem.table, item);
    refresh();
  } // END _delete()

  void _createFoodItem(BuildContext context) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Create New Task"),
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
                  labelText: 'Restaurant Name',
                  hintText: "Domino's pizza"),
              onChanged: (value) { tempFood = value; },
            ),
          );
        }
    );
  }

  @override
  void initState() {

    refresh();
    print("refreshed");
    super.initState();
  }

  void refresh() async {

    List<Map<String, dynamic>> _results = await DBFOOD.query(FoodItem.table);
    myFoods = _results.map((item) => FoodItem.fromMap(item)).toList();
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