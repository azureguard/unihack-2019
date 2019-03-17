import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/task.dart';
import 'task_manager.dart';
import 'queries.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TaskArea();
  }
}

class NotificationArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Task")
            .where("Emergency", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            return Container(
              height: MediaQuery.of(context).size.height / 20,
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("There are Emergency Tasks",style: TextStyle(color: Colors.white),)],
                ));
          } else {
            return Container();
          }
        });
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
  bool _taskManager = false;
  @override
  Widget build(BuildContext context) {
    // FutureBuilder test = FutureBuilder(builder: (context, snapshot) {
    //   ExpansionPanel(
    //       headerBuilder: (context, isExpanded) => Row(
    //             children: <Widget>[Text("test")],
    //           ),
    //       body: Text("test2"));
    // });
    if (_taskManager == false) {
      return Column(
        children: <Widget>[
          NotificationArea(),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text("Upcoming Tasks",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Spacer(),
                        RaisedButton(
                          child: Text("View All",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () => setState(() {
                                this._taskManager = true;
                              }),
                          color: Theme.of(context).primaryColor,
                        )
                      ]),
                      Container(
                        height: 13,
                      ),
                      TaskList(),
                    ],
                  ))),
        ],
      );
    } else {
      this._taskManager = false;
      return TaskManagerWidget();
    }
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TaskPanel> _panels;
  @override
  void initState() {
    super.initState();
    _panels = [];
  }

  createTaskPanel(Task task) {
    // this.setState(() => _panels = List.from(_panels)
    //   ..add(TaskPanel(
    //       task.title, task.description, task.start, task.due, false)));
    _panels = List.from(_panels)
      ..add(
          TaskPanel(task.title, task.description, task.start, task.due, false));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(children: [
      StreamBuilder<QuerySnapshot>(
          stream: DoQuery.fetchAllCurrentTask(),
          builder: (context, snapshot) {
            if (snapshot.hasData && _panels.isEmpty) {
              List tasks = snapshot.data.documents;
              for (DocumentSnapshot task in tasks) {
                createTaskPanel(Task(
                    title: task.data["Title"],
                    description: task.data["Description"],
                    start: task.data["Start"],
                    due: task.data["Due"]));
              }
            }
            return ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() => _panels[index].isExpanded = !isExpanded);
                },
                children: _panels
                    .map(
                      (TaskPanel panel) => ExpansionPanel(
                          headerBuilder: (context, isExpanded) => Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: 13),
                                      child: Container(
                                        child: Row(children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width / 4,
                                            child: Text(
                                                DateFormat("h:mma")
                                                    .format(panel.start),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.indigo[900])),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: Text(
                                              panel.title,
                                              style: TextStyle(fontSize: 18),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ]),
                                      ))
                                ],
                              ),
                          isExpanded: panel.isExpanded,
                          body: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      panel.title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 13,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(panel.description),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    )
                    .toList());
          }),
    ]));
  }
}
