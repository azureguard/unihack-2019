import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NotificationArea(),
      TaskArea(),
      // TimetableArea(),
    ]);
  }
}

class NotificationArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Text("Notification for Emergency")],
    );
  }
}

class TaskArea extends StatefulWidget {
  @override
  _TaskAreaState createState() => _TaskAreaState();
}

class _TaskAreaState extends State<TaskArea> {
  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    // FutureBuilder test = FutureBuilder(builder: (context, snapshot) {
    //   ExpansionPanel(
    //       headerBuilder: (context, isExpanded) => Row(
    //             children: <Widget>[Text("test")],
    //           ),
    //       body: Text("test2"));
    // });
    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Text("Tasks",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Spacer(),
                  RaisedButton(
                    child:
                        Text("View All", style: TextStyle(color: Colors.white)),
                    onPressed: () => null,
                    color: Theme.of(context).primaryColor,
                  )
                ]),
                Expanded(
                    child: ListView(children: [
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {});
                    },
                    children: [
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) => Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(children: <Widget>[
                                        Text("08:00",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(" "),
                                        Text("test",
                                            style: TextStyle(fontSize: 18)),
                                      ]))
                                ],
                              ),
                          body: Text("test2")),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) => Row(
                                children: <Widget>[Text("test")],
                              ),
                          body: Text("test2")),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) => Row(
                                children: <Widget>[Text("test")],
                              ),
                          body: Text("test2")),
                    ],
                  ),
                ]))
              ],
            )));
  }
}

class TimetableArea extends StatelessWidget {
  final data = [
    {"time": "08:00", "name": "event"},
    {"time": "09:00", "name": "eent"},
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => ListTile(
          leading: Text(data[index]['time']), title: Text(data[index]['name'])),
      itemCount: data.length,
    ));
  }
}
