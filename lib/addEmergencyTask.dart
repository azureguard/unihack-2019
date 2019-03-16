import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:intl/intl.dart';

class AddEmergencyTask extends StatefulWidget {
  AddEmergencyTask({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddEmergencyTaskState createState() => _AddEmergencyTaskState();
}

class _AddEmergencyTaskState extends State<AddEmergencyTask> {
  //final titleController = TextEditingController();

  List<DropdownMenuItem<String>> nameList = [];
  String selected = null;

  void loadNames() {
    nameList = [];
    nameList.add(
      new DropdownMenuItem(
        child: new Text("Daryl"),
        value: 'N1',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Maurice"),
        value: 'N2',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Alvin"),
        value: 'N3',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Michelle"),
        value: 'N4',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Novan"),
        value: 'N5',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Carisa"),
        value: 'N6',
      ),
    );
  }

  List<DropdownMenuItem<String>> categoryList = [];

  void loadCategories() {
    categoryList = [];
    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Date issued"),
        value: 'N1',
      ),
    );

    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Person who issued"),
        value: 'N2',
      ),
    );

    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Category"),
        value: 'N3',
      ),
    );
  }

  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadNames();
    loadCategories();

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter emergency task title',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Number of people needed for task: ',
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                width: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '#',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Description: ',
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                maxLines: 2,
                style: new TextStyle(
                  fontSize: 12,
                  height: 2.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: 'Enter task description',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 15.0,
                  right: 5.0,
                  top: 15.0,
                ),
                child: Text(
                  'Assigned to: ',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  bottom: 10.0,
                  right: 0.0,
                  top: 10.0,
                ),
                child: new DropdownButton(
                  value: selected,
                  elevation: 1,
                  items: nameList,
                  hint: new Text('Select Item'),
                  onChanged: (value) {
                    selected = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              //checkbox
              new Checkbox(
                  value: _isChecked,
                  onChanged: (bool value) {
                    onChanged(value);
                  }),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  bottom: 15.0,
                  right: 0.0,
                  top: 15.0,
                ),
                child: Text(
                  'Do not disturb',
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () => print("presses"),
            textColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Text("Submit"),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
