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
  ];

  Widget build(BuildContext context) {
    final contacts = <Contact>[];

    for (var i = 0; i < _contactName.length; i++) {
      contacts.add(Contact(
        iconLocation: _iconLocation,
        name: _contactName[i],
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