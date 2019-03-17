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
        // .orderBy("Start")
        // .where("AssignedTo", arrayContains: _singleton.getCurrentUserID)
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchAllCurrentEmergencyTask() {
    return Firestore.instance
        .collection("Task")
        .where("Event", isEqualTo: _singleton.getCurrentEvent)
        .where("Emergency", isEqualTo: true)
        // .orderBy("Start")
        // .where("AssignedTo", arrayContains: _singleton.getCurrentUserID)
        .snapshots();
  }

  // static List<Profile> fetchAllImportantProfiles() {
  //   List<String> userIDs;
  //   List<Profile> profiles;
  //   Firestore.instance
  //       .collection('Events')
  //       .document(_singleton.getCurrentEvent)
  //       .snapshots()
  //       .listen((data) =>
  //           userIDs = new List.from(data['Participants']['Admins'])
  //             ..addAll(data['Participants']['Regulars']));

  //   for (var userID in userIDs) {
  //     Profile newProfile = new Profile();
  //     DocumentSnapshot currentProfile;
  //     Firestore.instance
  //         .collection('Profiles')
  //         .where("UserID", isEqualTo: userID)
  //         .snapshots()
  //         .listen(
  //             (data) => data.documents.forEach((doc) => currentProfile = doc));
  //     newProfile.email = currentProfile['Email'];
  //     newProfile.name = currentProfile['Name'];
  //     newProfile.phone = currentProfile['Phone'];
  //     newProfile.userID = currentProfile['UserID'];
  //     profiles.add(newProfile);
  //   }
  //   return profiles;
  // }
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
        // .orderBy("Start")
        .limit(2)
        .snapshots();
  }

  // static bool isAdmin() {
  //   List<String> admins;
  //   Firestore.instance
  //       .collection('Events')
  //       .document(_singleton.getCurrentEvent)
  //       .snapshots()
  //       .listen((data) => admins = data['Participants']['Admins']);
  //   for (var admin in admins) {
  //     if (admin == _singleton.getCurrentUserID) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
  // List<Event> fetchAllEvents() {
  //   var list = [];
  //   Firestore.instance.collection('Events').where(field)
  //   return list;
  // }

  DoQuery._internal();
}
