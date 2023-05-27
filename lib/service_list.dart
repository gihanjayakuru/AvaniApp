import 'package:flutter/material.dart';

import 'list_screen.dart';

class ServiceListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> serviceDetails;
  final List<dynamic>? mergedFormDataList;

  ServiceListScreen({
    required this.serviceDetails,
    this.mergedFormDataList,
  });
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  List<Map<String, dynamic>> mergedServiceDetails = [];

  void _showAdditionalDetailsScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListScreen(),
      ),
    );

    if (result != null) {
      // Merge the selected location and additional details
      Map<String, dynamic> mergedData = {
        'location': result['location'],
        'additionalDetails': result['additionalDetails'],
      };

      setState(() {
        mergedServiceDetails.add(mergedData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List'),
      ),
      body: ListView.builder(
        itemCount: mergedServiceDetails.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> service = mergedServiceDetails[index];
          return GestureDetector(
            onTap: () {
              _showServiceDetailsDialog(service);
            },
            child: Card(
              child: ListTile(
                title: Text(service['location']),
                subtitle: Text(service['additionalDetails']),
                trailing: Text(service['createdDate']),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAdditionalDetailsScreen,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showServiceDetailsDialog(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Location: ${service['location']}'),
              Text('Additional Details: ${service['additionalDetails']}'),
              Text('Created Date: ${service['createdDate']}'),
              // Add more details here if needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
