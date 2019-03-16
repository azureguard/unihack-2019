import 'package:flutter/material.dart';

class Global extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Icon(Icons.location_on),
            Text("Telstra Labs", style: Theme.of(context).textTheme.headline)
          ]),
          Row(children: <Widget>[
            Icon(Icons.access_time),
            Column(children: <Widget>[
              Text("9.30AM 16 March"),
              Text("6.30PM 17 March")
            ])
          ]),
          Schedule(),
        ]));
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
        child: ListView.builder(
      itemBuilder: (context, index) => ListTile(
          leading: Text(
            data[index]['time'],
            style: Theme.of(context).textTheme.subhead,
          ),
          title: Text(data[index]['name'])),
      itemCount: data.length,
    ));
  }
}
