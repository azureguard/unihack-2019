import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class Contact extends StatefulWidget {
  final IconData iconLocation;
  final String name;

  const Contact({Key key, @required this.name, @required this.iconLocation})
      : assert(name != null),
        assert(iconLocation != null),
        super(key: key);

  @override
  _ContactState createState() => new _ContactState();
}

//State is information of the application that can change over time or when some actions are taken.
class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: InkWell(
          highlightColor: Colors.grey[400],
          splashColor: Colors.grey[400],

          child: ListTile(
              leading: Icon(IconData(59475, fontFamily: 'MaterialIcons')),
              title: Text(widget.name),
              trailing: Icon(Icons.phone),
              onTap: () { print('Tapped'); },
          ),
        ),
      ),
    );
  }
}
