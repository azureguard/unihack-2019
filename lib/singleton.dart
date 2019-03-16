class Singleton {
  static final Singleton _singleton = new Singleton._internal();
  static String _userID = "";
  static String _currentEvent = "";

  factory Singleton() {
    return _singleton;
  }

  String get getCurrentEvent => _currentEvent;
  String get getCurrentUserID => _userID;
  Singleton._internal();
}
