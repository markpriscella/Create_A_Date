import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:random_date_night/foodBody.dart';
import 'package:random_date_night/activityBody.dart';




class HomeBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeBodyState();
} // end HomeBody

// homeBodyState
class HomeBodyState extends State<HomeBody> {

  Color colorBackground = const Color.fromRGBO(57, 47, 90, 1.0);
  Color colorText = const Color.fromRGBO(240, 146, 221, 1.0);

  Color colorButton = const Color.fromRGBO(238, 200, 224, 1.0);
  Color colorButtonSplash = const Color.fromRGBO(255, 175, 240, 1.0);

  String randomFood = "Food";
  String randomActivity = "Activity";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,


        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView (
              children: <Widget>[
                const SizedBox(width: 100, height: 30), // used for spacing
                Center(
                  // TITLE OF THE PAGE
                  child: Text('Create a Date',
                      style: TextStyle(
                        fontSize: 45.0,
                        fontFamily: 'KaushanScript',
                        color: colorText,
                      )
                  ),
                ),
                const SizedBox(width: 100, height: 30), // used for spacing
                Center(
                  child: Text('Steps to create a random date:',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: colorText,
                        fontFamily: 'ComicNeue',
                      )
                  ),
                ),
                const SizedBox(width: 100, height: 15), // used for spacing

                Text('1. Add some food ideas to the food list',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 21.0,
                      color: colorText,
                      fontFamily: 'ComicNeue',
                    )
                ),

                const SizedBox(width: 100, height: 15), // used for spacing

                Text('2. Add activity ideas to the activity list',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: colorText,
                      fontFamily: 'ComicNeue',
                    )

                ),
                const SizedBox(width: 100, height: 15), // used for spacing

                Text('3. Tap below to create a random date!',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: colorText,
                      fontFamily: 'ComicNeue',
                    )

                ),
                const SizedBox(width: 100, height: 0), // used for spacing
                Center(
                  child: Text('* Make sure steps 2 & 3 are completed! *',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: colorText,
                        fontFamily: 'ComicNeue',
                      )
                  ),
                ),
                const SizedBox(width: 100, height: 15), // used for spacing

                Text('''4. If you don't like the date, 
            then press the button again!''',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: colorText,
                      fontFamily: 'ComicNeue',
                    )

                ),

                const SizedBox(width: 100, height: 70), // used for spacing
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                  child: Center(
                    child: Text(randomFood + " + " + randomActivity,
                        style: TextStyle(
                          fontSize: 32.0,
                          color: colorText,
                          fontFamily: 'ComicNeue',
                        )
                    ),
                  ),
                ),

                const SizedBox(width: 100, height: 10), // used for spacing

                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(95, 19, 95, 19),
                    child: MaterialButton(
                      minWidth: 100,
                      height: 40,
                      // front end details colorButton
                      color: colorButtonSplash,
                      splashColor: Colors.lightBlueAccent,
                      // what happens when button is pressed
                      onPressed: () async{
                        randomFood = await getRandomFood();
                        randomActivity = await getRandomActivity();
                        setState(() {
                          // calling so the screen refreshes with random date
                        });
                      },
                      child: const Text('Tap to Create a Date!',
                        style: TextStyle(
                          fontFamily: 'ComicNeue',
                        ),
                      ),

                    ),
                  ),
                )
              ]
          ),
        )
    );
  } // Build
} // FOOD SCREEN OVER