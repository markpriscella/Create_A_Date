import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:random_date_night/FoodItem.dart';
import 'package:random_date_night/dbfood.dart';

// returns random food from list
Future<String> getRandomFood() async {
  // create FoodItem to hold random food selected
  FoodItem randomFood;
  // select and set randomFood
  randomFood = await DBFOOD.getRandFood();
  // make sure randomFood is not null and return the random food
  if(randomFood != null) { return randomFood.name; }
  // did not perform as expected so return null
  return null;
}

// FoodBody creates a state for FoodBodyState
class FoodBody extends StatefulWidget {

  FoodBody({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FoodBodyState();
}

// FOOD SCREEN
class FoodBodyState extends State<FoodBody> {

  Color colorBackground = const Color.fromRGBO(57, 47, 90, 1.0);
  Color colorText = const Color.fromRGBO(240, 146, 221, 1.0);

  Color colorButton = const Color.fromRGBO(238, 200, 224, 1.0);
  Color colorButtonSplash = const Color.fromRGBO(255, 175, 240, 1.0);


  // create the list to hold Food places
  List<FoodItem> myFoods = [];

  // temporary string to hold food names
  String tempFood;

  // takes the item, formats it to a list, creates map of items for listView
  List<Widget> get _listItems => myFoods.map((item) => format(item)).toList();

  Widget format(FoodItem item) {

    // creates a dismissible list tile
    return Dismissible(
      // key of the item
      key: Key(item.id.toString()),
      // create padding
      child: Padding(
        // add some padding for the list tiles
          padding: EdgeInsets.fromLTRB(12, 6, 12, 4),
          // create flat button
          child: FlatButton(
            // set orientation
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //widgets of the row
                children: <Widget>[
                  // creates text
                  Text(item.name, style: TextStyle(
                    color: colorText,
                    fontSize: 24.0,
                    fontFamily: 'ComicNeue',
                  )),
                ]
            ),
            onPressed: (){},
          )
      ),
      // deletes item when tile is swiped in either direction
      onDismissed: (DismissDirection direction) => _delete(item),
    );
  }



  // create food item in _dbfood
  void _save() async {
    // get rid of the dialog and text box
    Navigator.of(context).pop();
    // create food item to be saved
    FoodItem foodSave = FoodItem(name: tempFood,);
    // insert the food item to be saved and wait for completion
    await DBFOOD.insert(FoodItem.table, foodSave);
    // set state and reset tempFood
    setState(() => tempFood = '');
    // call refresh to refresh food list
    refresh();
  } // END _save()

  // delete food item in _dbfood
  void _delete(FoodItem item) async {
    // delete the food and wait for completion
    await DBFOOD.delete(FoodItem.table, item);
    // call refresh to refresh food list
    refresh();
  } // END _delete()

  // creates dialog and text box to add food item to the list
  void _createFoodItem(BuildContext context) {
    // create dialog widget
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // define type of dialog
          return AlertDialog(
            // set the text
            title: Text("Add a new Restaurant"),
            // add bottons to save or cancel
            actions: <Widget>[
              // create cancel button
              FlatButton(
                // set the text
                  child: Text('Cancel'),
                  // remove the dialog and text box
                  onPressed: () => Navigator.of(context).pop()
              ),
              // create save button
              FlatButton(
                // set the text
                  child: Text('Save'),
                  // save the text in the text box and remove dialog and text box
                  onPressed: () => _save()
              )
            ],
            // create textField
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                // prompt the user what to enter
                  labelText: 'Restaurant Name',
                  // extra hint for the user
                  hintText: "Chinese Food"),
              // when text field is changed update temporary food
              onChanged: (value) { tempFood = value; },
            ),
          );
        } // end builder
    ); // end dialog
  } // end create food item

  // over ride the initState function to add refresh function
  @override
  void initState()  {
    // refresh the list and set state
    refresh();
    // run normal initState
    super.initState();
  }

  // refresh the food list
  void refresh() async {
    // get food item table from _dbfood
    List<Map<String, dynamic>> _results = await DBFOOD.query(FoodItem.table);
    // creates food item from query result and make it into a list
    myFoods = _results.map((item) => FoodItem.fromMap(item)).toList();
    // set the state
    setState( () {} );
  }

  @override
  Widget build(BuildContext context) {
    // create scaffold
    return Scaffold(
        backgroundColor: colorBackground,
        // set orientation
        body: ListView( children: <Widget> [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
            child: Center(
              // TITLE OF THE PAGE
              child: Text('Food List',
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
        // create floating action button
        floatingActionButton: FloatingActionButton(

          // launch dialog and text box to add new food item
          onPressed: () { _createFoodItem(context); },
          // button hint for user
          tooltip: 'Add a new food choice here!',
          // set icon for floating action button
          child: Icon(Icons.library_add),
        )
    );
  } // end build
} // FOOD SCREEN OVER