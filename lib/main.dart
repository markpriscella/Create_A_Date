import 'package:flutter/material.dart';
import 'foodBody.dart';
import 'funBody.dart';
import 'homeScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Date Night',
      theme: ThemeData(

        primarySwatch: Colors.lightBlue,
      ),
      home: HomeScreen(),
    );
  }
}






Widget textSaveFun() {
  return
    Wrap(
      children: [
        Container(
          width: 300,
          child: TextField (
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration (
                border: InputBorder.none,
                hintText: 'Add an activity to the list here!'
            ),
          ),
        ),
        ButtonTheme(
          minWidth: 60,
          child: RaisedButton (
              onPressed: () {},
              child: Text('Save',
                style: TextStyle(fontSize: 20),
              )
          ),
        ),
      ],
    );
}
