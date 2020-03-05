import 'package:flutter/material.dart';
import 'foodBody.dart';
import 'funBody.dart';
import 'homeBody.dart';

// HOME
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
} // END HOME

// HOME SCREEN
class HomeScreenState extends State<HomeScreen> {

  /*
  we want the app to start on the "create a date" page which is index 1
  there will be three tabs indexed 0 - 2
  */
  int _currentIndex = 1;

  // this array will hold the widgets that will make up the "body" of the app
  final pageOptions = [
    new FoodBody(),
    new HomeBody(),
    new FunBody(),
  ]; //

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dating App'),
      ),

      body: pageOptions.elementAt(_currentIndex),
      // tabs[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_dining),
            title: new Text('Food List'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Create a Date'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.sentiment_very_satisfied),
            title: new Text('Fun List'),
          ),
        ],
        // this will be set when a new tab is pressed
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightBlueAccent, //change color if wanted

        // this will be called when a navigation tab is pressed
        onTap: onItemTapped,

      ),
    );
  } // Build

  // this will be ran whenever a bottom navigation item is pressed
  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }// end onItemTapped

} // HomeScreen