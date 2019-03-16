import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

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
  //final titleController = TextEditingController();

  List<DropdownMenuItem<String>> listDrop = [];

  void loadData() {
    listDrop = [];
    listDrop.add(
      new DropdownMenuItem(
        child: new Text("Item No.1"),
        value: 'Value 1',
      ),
    );

    listDrop.add(
      new DropdownMenuItem(
        child: new Text("Item No.2"),
        value: 'Value 2',
      ),
    );

    listDrop.add(
      new DropdownMenuItem(
        child: new Text("Item No.3"),
        value: 'Value 3',
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
    loadData();

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
            ),
          ),

          //create a class for all text so that we don't hardcode (?)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Time start: ',
                  ),
                ),
              ),
              */
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Category: ',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new DropdownButton(
                    value: null,
                    items: listDrop,
                    hint: new Text('Select Item'),
                    onChanged: (item) => {print(item)},
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
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Assigned to: ',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new DropdownButton(
                  value: null,
                  items: listDrop,
                  hint: new Text('Select Item'),
                  onChanged: (item) => {print(item)},
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
                padding: const EdgeInsets.all(15.0),
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
