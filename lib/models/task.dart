import 'package:unihack2019/singleton.dart';
import 'profile.dart';

class Task {
  bool isEmergency, doNotDisturb, isFinished;
  String category, description, title, event;
  int numOfPeople;
  DateTime start, due;
  List<String> assignedTo = [];

  void assignTo(Profile profile) {
    assignedTo.add(profile.userID);
  }

  Task() {
    Singleton temp = new Singleton();
    event = temp.getCurrentEvent;
  }

  Map allMapped() {
    Map map = {
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
