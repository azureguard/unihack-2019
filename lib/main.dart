// This example shows a [Scaffold] with an [AppBar], a [BottomAppBar] and a
// [FloatingActionButton]. The [body] is a [Text] placed in a [Center] in order
// to center the text within the [Scaffold] and the [FloatingActionButton] is
// centered and docked within the [BottomAppBar] using
// [FloatingActionButtonLocation.centerDocked]. The [FloatingActionButton] is
// connected to a callback that increments a counter.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _count = 0;
  int _currentIndex = 0;
  Widget _currentBody = Center(
    child: Text('You have pressed the button times.'),
  );

  // Put main page widget here
  List<Widget> _widgetList = [
    // Homepage
    Center(
      child: Text('You have pressed the button times.'),
    ),
    // Event
    Center(
      child: Text('You have ped the button times.'),
    ),
    // Add Task (Won't be used)
    Center(
      child: Text('You have ssed the button times.'),
    ),
    // Emergency
    Center(
      child: Text('You have pred the button times.'),
    ),
    // Contacts
    Center(
      child: Text('You have pd the button times.'),
    )
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Name'),
      ),
      body: _currentBody,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _count = index;
            _currentIndex = index;
            _currentBody = _widgetList[index];
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
