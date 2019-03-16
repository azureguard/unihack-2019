import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'emergency.dart';
import 'addEmergencyTask.dart';
import 'addTask.dart';
import 'contact_route.dart';
import 'singleton.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _handleSignIn() async {
    var user = FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'dumyeet1@test.com', password: 'admin123');
    // user.then((currentUser) => Singleton.userID = currentUser.uid);
    print("YEET");
    user.then((currentUser) => print(currentUser.uid));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _handleSignIn();
    Singleton.currentEvent = "UMqMfWIq2xc4vSZhSTXH";
    
    return MaterialApp(
      // TODO: put our app name here
      title: 'Flutter Code Sample for material.Scaffold',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentIndex = 0;
  // fill in with dummy widget
  Widget _currentBody = Center(
    child: Text('You have pressed the button times.'),
  );

  // Put main page widget here
  List<Widget> _widgetList = [
    // Homepage
    Home(),
    // Event
    Center(
      child: Text('You have ped the button times.'),
    ),
    // Add Task (Won't be used)
    Center(
      child: Text('You have ssed the button times.'),
    ),
    // Emergency
    EmergencyWidget(),
    // Contacts
    Center(
      child: Text('You have pd the button times.'),
    )
  ];

  void _navigateToAddNormalTask(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return AddNormalTask();
    }));
  }

  void _navigateToAddEmergencyTask(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return AddEmergencyTask();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // Optional drawer
      drawer: Drawer(
        child: DrawerHeader(
          child: Text("Hello"),
        ),
      ),

      appBar: AppBar(
        title: Text('Event Name'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: IconButton(
              icon: Icon(Icons.person),
              // TODO: implement the going to my profile page
              onPressed: () => {},
            ),
          )
        ],
      ),

      body: _currentBody,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 2) {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          label: Text("Normal Task"),
                          icon: Icon(
                            Icons.add_box,
                            size: 50,
                          ),
                          onPressed: () => _navigateToAddNormalTask(context),
                        ),
                        FlatButton.icon(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          label: Text("Emergency Task"),
                          icon: Icon(
                            Icons.error,
                            size: 50,
                          ),
                          onPressed: () => _navigateToAddEmergencyTask(context),
                        ),
                      ],
                    ),
                  );
                });
          }

          setState(() {
            if (index != 2){
              _currentIndex = index;
              _currentBody = _widgetList[index];
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.event,
              ),
              title: Text("Events")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
              ),
              title: Text("Add Task")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.error,
              ),
              title: Text("Emergency")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
              ),
              title: Text("Contacts")),
        ],
      ),
    );
  }
}
