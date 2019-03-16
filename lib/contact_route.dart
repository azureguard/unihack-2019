import 'package:flutter/material.dart';
import 'queries.dart';
import 'package:unihack2019/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const _iconLocation = IconData(59475, fontFamily: 'MaterialIcons');

class ContactRoute extends StatelessWidget {
  const ContactRoute();

  Widget build(BuildContext context) {

    return Container(
      // child: _buildContactWidgets(contacts),
      child: _buildContactWidgets(),
    );
  }

  // Widget _buildContactWidgets(List<Widget> contacts) {
  //   return ListView.builder(
  //     itemBuilder: (BuildContext context, int index) => contacts[index],
  //     itemCount: contacts.length,
  //   );
  // }

  Widget _buildContactWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: StreamBuilder<QuerySnapshot>(
          stream: DoQuery.fetchAllProfiles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot profiles = snapshot.data;

              return ListView.builder(
                itemCount: profiles.documents.length,
                itemBuilder: (context, index) {
                  Map profile = profiles.documents[index].data;
                  print(profile['Name']);
                  print(profile['UserID']);
                  return Contact(
                      iconLocation: _iconLocation,
                      name: profile['Name'],
                      phoneNum: profile['Phone'],
                      email: profile['Email'],
                      uid: profile['UserID']);
                },
              );
            } else {
              return Text("No data");
            }
          }),
    );
  }
}
