import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Global extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("Events").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map event = snapshot.data.documents.first.data;
            print(event);
            return Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.location_on),
                    Text(event["Location"],
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline)
                  ]),
                  Row(children: <Widget>[
                    Icon(Icons.access_time),
                    Column(children: <Widget>[
                      Text(DateFormat("h.mma dd MMMM").format(
                          event["StartTime"])),
                      Text(
                          DateFormat("h.mma dd MMMM").format(event["EndTime"])),
                    ])
                  ]),
                  Schedule(),
                ]));
          }
        });
  }
}

class Schedule extends StatelessWidget {
  final data = [
    {"time": "08:00", "name": "event"},
    {"time": "09:00", "name": "eent"},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("Events").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List schedule = snapshot.data.documents.first['Schedule'];
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      ListTile(
                          leading: Text(
                            DateFormat("h:m a")
                                .format(schedule[index].values.first),
                            style: Theme
                                .of(context)
                                .textTheme
                                .subhead,
                          ),
                          title: Text(schedule[index].keys.first)),
                  itemCount: schedule.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
