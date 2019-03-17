import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'queries.dart';

class Contact extends StatefulWidget {
  final IconData iconLocation;
  final String name, phoneNum, email, uid;

  const Contact(
      {Key key,
      @required this.name,
      @required this.iconLocation,
      @required this.phoneNum,
      @required this.email,
      @required this.uid})
      : assert(name != null),
        assert(iconLocation != null),
        assert(phoneNum != null),
        assert(email != null),
        // assert(uid != null),
        super(key: key);

  @override
  _ContactState createState() => new _ContactState();
}

//State is information of the application that can change over time or when some actions are taken.
class _ContactState extends State<Contact> {
  // Navigates to the Profile page
  void _navigateToProfile(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blue,
          ),
        ),
        body: ListView(
          children: [
            // implement of profile data including mobile, email and task
            ProfileImage(
              name: widget.name,
              iconLocation: widget.iconLocation,
            ),
            ProfileDetails(
              phoneNum: widget.phoneNum,
              email: widget.email,
              uid: widget.uid,
            ),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: InkWell(
          highlightColor: Colors.grey[400],
          splashColor: Colors.grey[400],
          child: ListTile(
            leading: Icon(
              IconData(59475, fontFamily: 'MaterialIcons'),
              color: Colors.blue[900],
            ),
            title: Text(widget.name),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              color: Colors.blue[900],

              onPressed: () {
                print('Tapped phone button on the Contact List');
              },
            ),
            onTap: () => _navigateToProfile(context),
          ),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String name;
  final IconData iconLocation;

  const ProfileImage({
    this.name,
    this.iconLocation,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        alignment: Alignment.topCenter,
        child: Column(children: [
          Icon(
            iconLocation,
            size: 120.0,
            color: Colors.blue,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.headline,
          )
        ]),
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  final String phoneNum, email, uid;

  const ProfileDetails({
    this.phoneNum,
    this.email,
    this.uid,
  });

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final dndStatus = false;

  Widget _buildDND() {
    if (dndStatus) {
      return Container(
        height: 24.0,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey[900]),
            bottom: BorderSide(width: 0.5, color: Colors.grey[900]),
          ),
          color: Colors.yellowAccent[400],
        ),
        child: Center(
          child: Text(
            'Do Not Disturb',
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey[900]),
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDND(),
          Container(height: 8),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Mobile : ${widget.phoneNum}',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      IconData(58705, fontFamily: 'MaterialIcons'),
                      color: Colors.blue[900],
                    ),

                    onPressed: () {
                      print('Tapped mobile button');
                    }),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    'Email   : ${widget.email}',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      IconData(58708, fontFamily: 'MaterialIcons'),
                      color: Colors.blue[900],
                    ),

                    onPressed: () {
                      print('Tapped email button');
                    }),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.5, vertical: 12.0),
            child: Text(
              'Task    : ',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: DoQuery.fetchTaskFor(widget.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      QuerySnapshot tasks = snapshot.data;
                      return ListView.builder(
                          itemCount: tasks.documents.length,
                          itemBuilder: (context, index) {
                            Map task = tasks.documents[index].data;
                            return UserTask(
                              title: task['Title'],
                              timeStart: task['Start'],
                              timeEnd: task['Due'],
                              category: task['Category'],
                              description: task['Description'],
                              dndStatus: task['DoNotDisturb'],
                            );
                          });
                    } else {
                      return Text("No data");
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserTask extends StatefulWidget {
  const UserTask({
    Key key,
    @required this.title,
    @required this.timeStart,
    @required this.timeEnd,
    @required this.category,
    @required this.description,
    @required this.dndStatus,
  });

  final String title;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String category;
  final String description;
  final bool dndStatus;

  @override
  _UserTaskState createState() => _UserTaskState();
}

class _UserTaskState extends State<UserTask> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 115,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text(
                      widget.category,
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              Container(
                height: 5.0,
              ),
              Text(
                "${DateFormat("h:mma").format(widget.timeStart)} - ${DateFormat("h:mma").format(widget.timeEnd)}",
                // "${widget.timeStart.hour}:${widget.timeStart.minute}-${widget.timeEnd.hour}:${widget.timeEnd.minute}",
              ),
              Container(
                height: 10.0,
              ),
              Text(
                widget.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
