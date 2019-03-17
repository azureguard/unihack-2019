import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'queries.dart';
import 'models/task.dart';
import 'singleton.dart';

// The Emergency Task Card
class EmergencyTaskCard extends StatefulWidget {
  const EmergencyTaskCard({
    Key key,
    @required this.title,
    @required this.numberOfPeople,
    @required this.description,
    @required this.dndStatus,
  });

  final String title;
  final int numberOfPeople;
  final String description;
  final bool dndStatus;

  @override
  _EmergencyTaskCardState createState() => _EmergencyTaskCardState();
}

class _EmergencyTaskCardState extends State<EmergencyTaskCard> {
  @override
  Widget build(BuildContext context) {
    // Put style here
    return Card(
      color: Colors.red[800],
      elevation: 5,
      child: Container(
        height: 168,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.title.apply(color: Colors.white),
              ),
              Text(
                widget.description,
                style: Theme.of(context).textTheme.body1.apply(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "0 / ${widget.numberOfPeople}",
                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                  ),
                  RaisedButton(
                    color: Colors.grey[200],
                    elevation: 3,
                    onPressed: () => {print("yo")},
                    child: Text('Accept'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyWidget extends StatefulWidget {
  EmergencyWidget({Key key}) : super(key: key);

  @override
  _EmergencyWidgetState createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: StreamBuilder<QuerySnapshot>(
          stream: DoQuery.fetchAllCurrentEmergencyTask(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot tasks = snapshot.data;

              return ListView.builder(
                itemCount: tasks.documents.length,
                itemBuilder: (context, index) {
                  Map task = tasks.documents[index].data;
                  return EmergencyTaskCard(
                      title: task['Title'],
                      description: task['Description'],
                      numberOfPeople: task['NumOfPeople'],
                      dndStatus: task['DoNotDisturb']);
                },
              );
            } else {
              return Text("No data");
            }
          }),
    );
  }
}
