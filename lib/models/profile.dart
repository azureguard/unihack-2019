import 'package:unihack2019/singleton.dart';

class Profile {
  String email, name, phone, userID;

  Profile() {
    Singleton temp = new Singleton();
    userID = temp.getCurrentUserID;
  }

  Map allMapped() {
    Map map = {
      'Email': email,
      'Name': name,
      'Phone': phone,
      'UserID': userID,
    };

    return map;
  }
}
