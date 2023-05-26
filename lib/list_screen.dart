import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> formDataList = [];

  @override
  void initState() {
    super.initState();
    // Load the saved form data list
    _loadFormDataList();
  }

  void _loadFormDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList('formDataList') ?? [];
    setState(() {
      formDataList = savedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Forms'),
      ),
      body: ListView.builder(
        itemCount: formDataList.length,
        itemBuilder: (context, index) {
          String formData = formDataList[index];
          return ListTile(
            title: Text(formData),
          );
        },
      ),
    );
  }
}
