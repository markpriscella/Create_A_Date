import 'package:flutter/material.dart';
import 'package:random_date_night/dbactivity.dart';
import 'package:random_date_night/dbfood.dart';
import 'homeScreen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DBFOOD.init();

  WidgetsFlutterBinding.ensureInitialized();

  await DBACTIVITY.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Color colorBackground = const Color.fromRGBO(240, 146, 221, 1.0);
  Color colorText = const Color.fromRGBO(57, 47, 90, 1.0);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Create A Date',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}
