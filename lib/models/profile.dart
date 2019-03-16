import 'package:unihack2019/singleton.dart';

class Profile {
  String email, name, phone, userID;

  Profile({this.email, this.name, this.phone, this.userID}) {
    Singleton temp = new Singleton();
    userID = temp.getCurrentUserID;
  }

  factory Profile.fromResult(Map<String, dynamic> map) => Profile(
    email: map['Email'],
    name: map['Name'],
    phone: map['Phone'],
    userID: map['UserID']
  );

  Map<String, dynamic> allMapped() {
    Map<String, dynamic> map = {
      'Email': email,
      'Name': name,
      'Phone': phone,
      'UserID': userID,
    };

    return map;
  }
}
