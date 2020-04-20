import 'package:flutter/material.dart';

class Fun {
  final String name;

  Fun(this.name);

  Fun.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() => {
    'category': "fun",
    'name': name,
  };
}

// FUN SCREEN STATE BUILDER
class FunBody extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => FunBodyState();
} // FUN SCREEN STATE BUILDER OVER

// FUN SCREEN
class FunBodyState extends State<FunBody> {

  // create the text controller - it will be used to retrieve
  // the value in the textField
  final myController = TextEditingController();

  // myController dispose() method
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // create the string list to hold Food places
  List<String> myActivities = List<String>();

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


  Widget textSaveFood() {
    return Wrap(
      children: [
        Container(
          width: 300,
          child: TextField (
            controller: myController,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration (
                border: InputBorder.none,
                hintText: 'Add an Activity to the list here!'
            ),
          ),
        ),
        ButtonTheme(
          minWidth: 60,
          child: RaisedButton (
              onPressed: () {
                setState(() {
                  // get text from textField and add it to myFoods list
                  myActivities.add(myController.text);
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
              child: _buildList(myActivities),
            ),
            textSaveFood(),
          ],
        ),
      ),


    );
  } // Build
} // FOOD SCREEN OVER