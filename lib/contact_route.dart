import 'package:flutter/material.dart';

import 'package:unihack2019/contact.dart';

const _iconLocation = IconData(59475, fontFamily: 'MaterialIcons');

class ContactRoute extends StatelessWidget {
  const ContactRoute();

  static const _contactName = <String>[
    'Daryl Wong',
    'Maurice',
    'Carisa',
    'Alvin',
    'Novan',
    'Michelle',
  ];

  static const _contactNum = <String>[
    '01234567890',
    '01923891301',
    '12312738912',
    '12831293821',
    '28749128421',
    '92394902384',
  ];

  static const _email = <String>[
    'darylwong@hotmail.com',
    'maurice@yahoo.com',
    'carisa@gmail.com',
    'alvinaksdjlkqwe@hotmail.com',
    'novan@gmail.com',
    'michelle@yahoo.com',
  ];

  Widget build(BuildContext context) {
    final contacts = <Contact>[];

    for (var i = 0; i < _contactName.length; i++) {
      contacts.add(Contact(
        iconLocation: _iconLocation,
        name: _contactName[i],
        phoneNum: _contactNum[i],
        email: _email[i],
      ));
    }

    return Container(
      child: _buildContactWidgets(contacts),
    );
  }

  Widget _buildContactWidgets(List<Widget> contacts) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => contacts[index],
      itemCount: contacts.length,
    );
  }
}