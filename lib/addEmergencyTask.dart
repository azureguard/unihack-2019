import 'package:flutter/material.dart';
//import 'dart:async';
import 'models/task.dart';
import 'queries.dart';
//import 'package:intl/intl.dart';

class AddEmergencyTask extends StatefulWidget {
  AddEmergencyTask({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddEmergencyTaskState createState() => _AddEmergencyTaskState();
}

class _AddEmergencyTaskState extends State<AddEmergencyTask> {
  //final titleController = TextEditingController();
  final emergencyController = new TextEditingController();
  final numOfPeopleController = new TextEditingController();
  final descriptionController = new TextEditingController();

  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              controller: emergencyController,
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
                    controller: numOfPeopleController,
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
                controller: descriptionController,
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
            onPressed: () => DoQuery.createNewTask(Task(
                  title: emergencyController.text,
                  numOfPeople: int.tryParse(numOfPeopleController.text),
                  description: descriptionController.text,
                  doNotDisturb: _isChecked,
                  assignedTo: [],
                  start: DateTime.now(),
                  category: "Emergency",
                  isEmergency: true,
                )),
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
