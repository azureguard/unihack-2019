import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'queries.dart';
import 'models/task.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _InputDropdown(
              labelText: labelText,
              valueText: DateFormat.yMMMd().format(selectedDate),
              valueStyle: valueStyle,
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            flex: 3,
            child: _InputDropdown(
              valueText: selectedTime.format(context),
              valueStyle: valueStyle,
              onPressed: () {
                _selectTime(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddNormalTask extends StatefulWidget {
  AddNormalTask({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddNormalTaskState createState() => _AddNormalTaskState();
}

class _AddNormalTaskState extends State<AddNormalTask> {
  List<DropdownMenuItem<String>> nameList = [];
  String selected1 = null;
  String selected2 = null;
  final titleController = new TextEditingController();
  final descriptionController = new TextEditingController();

  void loadNames() {
    nameList = [];
    nameList.add(
      new DropdownMenuItem(
        child: new Text("Daryl"),
        value: 'Daryl',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Maurice"),
        value: 'Maurice',
      ),
    );

    nameList.add(
      new DropdownMenuItem(
        child: new Text("Alvin"),
        value: 'Alvin',
      ),
    );
  }

  List<DropdownMenuItem<String>> categoryList = [];

  void loadCategories() {
    categoryList = [];
    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Getting food and drinks"),
        value: 'Getting food and drinks',
      ),
    );

    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Setting up"),
        value: 'Setting up',
      ),
    );

    categoryList.add(
      new DropdownMenuItem(
        child: new Text("Industry Point of Contact"),
        value: 'Industry Point of Contact',
      ),
    );
  }

  bool _isChecked = false;

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);

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
                hintText: 'Enter task title',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              controller: titleController,
            ),
          ),

          //create a class for all text so that we don't hardcode (?)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: _DateTimePicker(
                  labelText: 'From',
                  selectedDate: _fromDate,
                  selectedTime: _fromTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _fromDate = date;
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _fromTime = time;
                    });
                  },
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: _DateTimePicker(
                  labelText: 'To',
                  selectedDate: _toDate,
                  selectedTime: _toTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _toDate = date;
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _toTime = time;
                    });
                  },
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    bottom: 15.0,
                    right: 5.0,
                    top: 26.0,
                  ),
                  child: Text(
                    'Category: ',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    top: 12.0,
                  ),
                  child: new DropdownButton(
                    value: selected1,
                    elevation: 1,
                    items: categoryList,
                    hint: new Text('Select Item'),
                    onChanged: (value) {
                      selected1 = value;
                      setState(() {});
                    },
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
              padding: const EdgeInsets.only(
                left: 15.0,
                bottom: 0.0,
                right: 15.0,
                top: 0.0,
              ),
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
                controller: descriptionController,
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
                  elevation: 1,
                  value: selected2,
                  items: nameList,
                  hint: new Text('Select Item'),
                  onChanged: (value) {
                    selected2 = value;
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
            // When the user presses the button, show an alert dialog with the
            // text the user has typed into our text field.
            onPressed: () => DoQuery.createNewTask(Task(
                  title: titleController.text,
                  start: DateTime(_fromDate.year, _fromDate.month,
                      _fromDate.day, _fromTime.hour, _fromTime.minute),
                  due: DateTime(_toDate.year, _toDate.month, _toDate.day,
                      _toTime.hour, _toTime.minute),
                  category: selected1,
                  assignedTo: [selected2],
                  numOfPeople: 1,
                  description: descriptionController.text,
                  doNotDisturb: _isChecked,
                  isEmergency: false,
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
