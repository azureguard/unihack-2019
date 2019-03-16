import 'package:unihack2019/singleton.dart';
import 'profile.dart';

class Task {
  bool isEmergency, doNotDisturb, isFinished;
  String category, description, title, event;
  int numOfPeople;
  DateTime start, due;
  List<String> assignedTo = [];

  Task({
    this.title,
    this.doNotDisturb,
    this.start,
    this.due,
    this.description,
    this.assignedTo,
    this.category,
    this.isEmergency,
    this.numOfPeople,
  }) {
    this.event = Singleton.currentEvent;
    this.isFinished = false;
  }

  void assignTo(Profile profile) {
    assignedTo.add(profile.userID);
  }

  factory Task.fromResult(Map<String, dynamic> map) => Task();

  Map<String, dynamic> allMapped() {
    Map<String, dynamic> map = {
      "AssignedTo": assignedTo,
      "Category": category,
      "Description": description,
      "Due": due,
      "Emergency": isEmergency,
      "Event": event,
      "IsFinished": isFinished,
      "NumOfPeople": numOfPeople,
      "Start": start,
      "Title": title,
    };
    return map;
  }
}
