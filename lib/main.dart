import 'package:flutter/material.dart';
import 'package:random_date_night/dbfood.dart';
import 'package:random_date_night/foodBody.dart';
import 'package:random_date_night/funBody.dart';
import 'homeScreen.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DBFOOD.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create A Date',
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
