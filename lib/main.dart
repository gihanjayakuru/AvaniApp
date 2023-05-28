import 'package:avani_app/location_list.dart';
import 'package:flutter/material.dart';
import 'my_form_screen.dart';
import 'service_list.dart';

void main() {
  // List<Map<String, dynamic>> serviceDetails =
  //     []; // Add your service details here
  // List<dynamic> mergedFormDataList = []; // Add your merged form data here

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MyFormScreen(),
      LocationListScreen(),
      ServiceListScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo App'),
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'LocationList',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'ServiceList',
            ),
          ],
        ),
      ),
    );
  }
}
