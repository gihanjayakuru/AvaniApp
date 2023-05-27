import 'package:flutter/material.dart';

class ServiceListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> serviceDetails;
  final List<Map<String, dynamic>> mergedFormDataList;

  ServiceListScreen({
    required this.serviceDetails,
    required this.mergedFormDataList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List'),
      ),
      body: ListView.builder(
        itemCount: mergedFormDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> formData = mergedFormDataList[index];
          return Card(
            child: ListTile(
              title: Text('Location: ${formData['location']}'),
              subtitle:
                  Text('Additional Details: ${formData['additionalDetails']}'),
              trailing: Text('Created Date: ${formData['createdDate']}'),
            ),
          );
        },
      ),
    );
  }
}
