import 'package:flutter/material.dart';

class ServiceListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> serviceDetails;

  ServiceListScreen({required this.serviceDetails});

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List'),
      ),
      body: ListView.builder(
        itemCount: widget.serviceDetails.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> service = widget.serviceDetails[index];
          return GestureDetector(
            onTap: () {
              _showServiceDetailsDialog(service);
            },
            child: Card(
              child: ListTile(
                title: Text(service['serviceType']),
                subtitle: Text(service['serviceDescription']),
                trailing: Text(service['createdDate']),
              ),
            ),
          );
        },
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
              Text('Service Type: ${service['serviceType']}'),
              Text('Service Description: ${service['serviceDescription']}'),
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
