import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'queries.dart';

// The Emergency Task Card
class TaskCard extends StatefulWidget {
  const TaskCard({
    Key key,
    @required this.title,
    @required this.timeStart,
    @required this.timeEnd,
    @required this.category,
    @required this.description,
    @required this.assignedTo,
    @required this.dndStatus,
  });

  final String title;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String category;
  final List<dynamic> assignedTo;
  final String description;
  final bool dndStatus;

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    // Put style here

    return Card(
      child: Container(
        height: 168,
        width: 200,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/5,
                    child: Text(
                      widget.category,
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              Container(
                height: 5.0,
              ),
              Text(
                "${widget.timeStart.hour}:${widget.timeStart.minute}-${widget.timeEnd.hour}:${widget.timeEnd.minute}",
              ),
              Container(
                height: 10.0,
              ),
              Text(
                widget.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: Theme.of(context).textTheme.body1,
              ),
              Container(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskManagerWidget extends StatefulWidget {
  TaskManagerWidget({Key key}) : super(key: key);

  @override
  _TaskManagerWidgetState createState() => _TaskManagerWidgetState();
}

class _TaskManagerWidgetState extends State<TaskManagerWidget> {
  Widget build(BuildContext context) {
    // var details = [
    //   {
    //     "title": "hello",
    //     "timeStart": new DateTime(2017, 9, 7, 17, 30),
    //     "timeEnd": new DateTime(2017, 9, 7, 20, 30),
    //     "category": "food",
    //     "assignedTo": <String>["me", "you", "op"],
    //     "description": "Taking out some trash to people out theere yeayy okoko dajhk sd asdhswa hdsakhd sadhksa dsachs dhsaj dksa okoko dajhk sd asdhswa hdsakhd sadhksa dsachs dhsaj dksa okoko dajhk sd asdhswa hdsakhd sadhksa dsachs dhsaj dksa okoko dajhk sd asdhswa hdsakhd sadhksa dsachs dhsaj dksa dsadhjsah djklsahl sdlksdsahkdlsd",
    //     "dndStatus": true,
    //   },
    //   {
    //     "title": "hello",
    //     "timeStart": new DateTime(2017, 9, 7, 17, 30),
    //     "timeEnd": new DateTime(2017, 9, 7, 20, 30),
    //     "category": "food",
    //     "assignedTo": <String>["me", "you", "op"],
    //     "description": "Taking out some trash to people out theere yeayy okoko",
    //     "dndStatus": true,
    //   },
    //   {
    //     "title": "hello",
    //     "timeStart": new DateTime(2017, 9, 7, 17, 30),
    //     "timeEnd": new DateTime(2017, 9, 7, 20, 30),
    //     "category": "food",
    //     "assignedTo": <String>["me", "you", "op"],
    //     "description": "Taking out some trash to people out theere yeayy okoko",
    //     "dndStatus": true,
    //   },
    //   {
    //     "title": "hello",
    //     "timeStart": new DateTime(2017, 9, 7, 17, 30),
    //     "timeEnd": new DateTime(2017, 9, 7, 20, 30),
    //     "category": "food",
    //     "assignedTo": <String>["me", "you", "op"],
    //     "description": "Taking out some trash to people out theere yeayy okoko",
    //     "dndStatus": true,
    //   },
    //   {
    //     "title": "hello",
    //     "timeStart": new DateTime(2017, 9, 7, 17, 30),
    //     "timeEnd": new DateTime(2017, 9, 7, 20, 30),
    //     "category": "food",
    //     "assignedTo": <String>["me", "you", "op"],
    //     "description": "Taking out some trash to people out theere yeayy okoko",
    //     "dndStatus": true,
    //   },
    // ];

    // final cards = <TaskCard>[];

    // for (var i = 0; i < details.length; i++) {
    //   cards.add(TaskCard(
    //     title: details[i]["title"],
    //     timeStart: details[i]["timeStart"],
    //     timeEnd: details[i]["timeEnd"],
    //     category: details[i]["category"],
    //     assignedTo: details[i]["assignedTo"],
    //     description: details[i]["description"],
    //     dndStatus: details[i]["dndStatus"],
    //   ));
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: _buildTaskCard(),
    );
  }

  Widget _buildTaskCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: StreamBuilder<QuerySnapshot>(
          stream: DoQuery.fetchAllCurrentTask(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot tasks = snapshot.data;

              return ListView.builder(
                itemCount: tasks.documents.length,
                itemBuilder: (context, index) {
                  Map task = tasks.documents[index].data;
                  return TaskCard(
                    title: task['Title'],
                    description: task['Description'],
                    dndStatus: task['DoNotDisturb'],
                    timeEnd: task['Due'],
                    timeStart: task['Start'],
                    category: task['Category'],
                    assignedTo: task['AssignedTo'],
                  );
                },
              );
            } else {
              return Text("No data");
            }
          }),
    );
  }
}
