import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unihack2019/singleton.dart';
import 'dart:async';
import 'package:unihack2019/models/event.dart';
import 'package:unihack2019/models/task.dart';

class DoQuery {
  static final DoQuery _query = new DoQuery._internal();
  static String userID = "";
  static Singleton _singleton = new Singleton();

  factory DoQuery() {
    return _query;
  }

  static void createNewEvent(Event event) {
    Firestore.instance
        .collection('Events')
        .document()
        .setData(event.allMapped());
  }

  static void createNewTask(Task task) {
    Firestore.instance.collection('Task').document().setData(task.allMapped());
  }

  static Stream<QuerySnapshot> fetchAllCurrentTask() {
    return Firestore.instance
        .collection("Task")
        .where("Event", isEqualTo: _singleton.getCurrentEvent)
        .where("Emergency", isEqualTo: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchAllCurrentEmergencyTask() {
    return Firestore.instance
        .collection("Task")
        .where("Event", isEqualTo: _singleton.getCurrentEvent)
        .where("Emergency", isEqualTo: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchAllProfiles() {
    return Firestore.instance.collection("Profiles").snapshots();
  }

  static Stream<QuerySnapshot> fetchTaskFor(String userID) {
    return Firestore.instance
        .collection("Task")
        .where("Event", isEqualTo: _singleton.getCurrentEvent)
        .where("AssignedTo", arrayContains: userID)
        .where("Emergency", isEqualTo: false)
        .where("Start", isGreaterThanOrEqualTo: DateTime.now())
        .limit(2)
        .snapshots();
  }

  DoQuery._internal();
}
