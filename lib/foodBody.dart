import 'package:flutter/material.dart';

class Food {
  final String name;

  Food(this.name);

  Food.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {'name': name};
}

class FoodBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => FoodBodyState();
}


// FOOD SCREEN
class FoodBodyState extends State<FoodBody> {

  /*
  Create the text controller
  The text controller  will be used to retrieve the string in the textField
  */
  final myController = TextEditingController();

  // myController dispose() method
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // create the string list to hold Food places
  List<String> myFoods = List<String>();

  Widget _buildRow(String item) {
    return ListTile(
      title: Text(item),
    );
  } // _buildRow

  Widget _buildList( List<String> inputList) {
    return ListView.builder (
      itemCount: inputList.length,
      itemBuilder: (context, i) {
        return _buildRow(inputList[i]);
      }, // itemBuilder
    ); // ListView.builder
  } // _buildList

  /*
  This widget will create a type-able text field and a save button to save the
  user entered string to the list
   */
  Widget textSaveFood() {
    // wrap will try to fit all the contained widgets on one line
    return Wrap(
      children: [
        Container(
          width: 300,
          child: TextField (
            // give the TextField the controller in order to access the string
            controller: myController,
            // style the text in TextField
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration (
                border: InputBorder.none,
                hintText: 'Add a restuarant to the list here!'
            ),
          ),
        ),
        ButtonTheme(
          minWidth: 60,
          child: RaisedButton (
              onPressed: () {
                setState(() {
                  // get text from textField and add it to myFoods list
                  myFoods.add(myController.text);
                  myController.clear();
                }); // setState
              }, // onPressed
              child: Text('Save',
                style: TextStyle(fontSize: 20),
              )
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center (
        child: Column(
          children: <Widget> [
            Expanded (
              child: _buildList(myFoods),
            ),
            textSaveFood(),
          ],
        ),
      ),

    );
  } // Build
} // FOOD SCREEN OVER