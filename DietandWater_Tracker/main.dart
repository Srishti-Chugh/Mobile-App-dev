import 'package:flutter/material.dart';
import 'water_tracker.dart';
import 'diet_tracker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaterDietTracker(),
    );
  }
}

class WaterDietTracker extends StatefulWidget {
  @override
  _WaterDietTrackerState createState() => _WaterDietTrackerState();
}

class _WaterDietTrackerState extends State<WaterDietTracker> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    WaterTrackerPage(),
    DietTrackerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Health Tracker'),
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Water Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Diet Tracker',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
