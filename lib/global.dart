import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Global extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("Events").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map event = snapshot.data.documents.first.data;
                  return Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.red[600],
                        ),
                        Container(width: 10),
                        Text(event["Location"],
                            style: Theme.of(context).textTheme.headline)
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.blue[900],
                        ),
                        Container(width: 10),
                        Column(children: <Widget>[
                          Text(DateFormat("h.mma dd MMMM")
                              .format(event["StartTime"])),
                          Text(DateFormat("h.mma dd MMMM")
                              .format(event["EndTime"])),
                        ])
                      ]),
                    ),
                    Container(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 0.01,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.grey))),
                    )
                  ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          Schedule(),
        ]));
  }
}

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("Events").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List schedule = snapshot.data.documents.first['Schedule'];
                schedule.sort(
                    (a, b) => a.values.first.isAfter(b.values.first) ? 1 : -1);
                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text(
                                DateFormat("h:mm a")
                                    .format(schedule[index].values.first),
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                            Container(
                              child: Text(
                                schedule[index].keys.first,
                              ),
                            ),
                          ],
                        ),
                      ),
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
