import 'package:flutter/material.dart';
import 'home_page.dart';
import 'list_screen.dart';
import 'service_list.dart';

void main() {
  List<Map<String, dynamic>> serviceDetails =
      []; // Add your service details here
  List<dynamic> mergedFormDataList = []; // Add your merged form data here

  runApp(MyApp(
    serviceDetails: serviceDetails,
    mergedFormDataList: mergedFormDataList,
  ));
}

class MyApp extends StatefulWidget {
  final List<Map<String, dynamic>> serviceDetails;
  final List<dynamic> mergedFormDataList;

  MyApp({required this.serviceDetails, required this.mergedFormDataList});

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
      ListScreen(),
      ServiceListScreen(
        serviceDetails: widget.serviceDetails,
        mergedFormDataList: widget.mergedFormDataList,
      ),
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
          title: Text('ToDo App'),
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
