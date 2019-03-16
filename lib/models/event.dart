import 'profile.dart';

class Event {
  String location, description, title;
  DateTime startTime, endTime;
  var participants = [];
  var schedule = new Map();

  void addParticipants(String participant) => participants.add(participant);
  void addAdmin(Profile prof) => participants.add({
        prof.userID: 'admin',
      });

  void addRegular(Profile prof) => participants.add({
        prof.userID: 'regular',
      });
      
  void addSchedule(String activity, DateTime time) =>
      this.schedule[activity] = time;

  Map allMapped() {
    Map map = {
      "Description": description,
      "EndTime": endTime,
      "Location": location,
      "Participants": participants,
      "Schedule": schedule,
      "StartTime": startTime,
      "Title": title,
    };
    return map;
  }
}
