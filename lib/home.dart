import 'package:flutter/material.dart';
import 'models/task.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NotificationArea(),
      TaskArea(),
    ]);
  }
}

class NotificationArea extends StatelessWidget {
  //TODO: put in the actual boolean
  bool taskPresent = !true;

  @override
  Widget build(BuildContext context) {
    if (taskPresent) {
      return Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("There are Emergency Tasks")],
          ));
    } else {
      return Container();
    }
  }
}

class TaskArea extends StatefulWidget {
  @override
  _TaskAreaState createState() => _TaskAreaState();
}

class TaskPanel {
  bool isExpanded;
  String description, title;
  DateTime start, due;
  TaskPanel(
      this.title, this.description, this.start, this.due, this.isExpanded);
}

class _TaskAreaState extends State<TaskArea> {
  List<TaskPanel> _panels;
  @override
  void initState() {
    super.initState();
    _panels = [];
//    createTaskPanel(
//        Task("Title", "description", DateTime(2019), DateTime(2020)));
  }

  createTaskPanel(Task task) {
    this.setState(() => _panels = List.from(_panels)
      ..add(TaskPanel(
          task.title, task.description, task.start, task.due, false)));
  }

  @override
  Widget build(BuildContext context) {
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
                  Text("Upcoming Tasks",
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
                        setState(() => _panels[index].isExpanded = !isExpanded);
                      },
                      children: _panels
                          .map(
                            (TaskPanel panel) => ExpansionPanel(
                                headerBuilder: (context, isExpanded) => Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Row(children: <Widget>[
                                              Text(panel.start.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(" "),
                                              Text(panel.title,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                            ]))
                                      ],
                                    ),
                                isExpanded: panel.isExpanded,
                                body: Text(panel.description)),
                          )
                          .toList()),
                ]))
              ],
            )));
  }
}
