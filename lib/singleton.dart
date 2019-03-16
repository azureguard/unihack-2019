class Singleton {
  static final Singleton _singleton = new Singleton._internal();
  static String userID = "";
  static String currentEvent = "";

  factory Singleton() {

    return _singleton;
  }
  String get getCurrentEvent => currentEvent;
  String get getCurrentUserID => userID;
  Singleton._internal();
}
