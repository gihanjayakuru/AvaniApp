import 'package:flutter/material.dart';
import 'list_screen.dart';

class FullDetailsScreen extends StatelessWidget {
  final FormData formData;

  FullDetailsScreen({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Location'),
              subtitle: Text(formData.location),
            ),
            ListTile(
              title: Text('Indoor Model'),
              subtitle: Text(formData.indoorModel),
            ),
            ListTile(
              title: Text('Indoor Model Number'),
              subtitle: Text(formData.indoorModelNum),
            ),
            ListTile(
              title: Text('Indoor Serial Number'),
              subtitle: Text(formData.indoorSerialNum),
            ),
            ListTile(
              title: Text('Indoor Capacity'),
              subtitle: Text(formData.indoorCapacity),
            ),
            ListTile(
              title: Text('Outdoor Model'),
              subtitle: Text(formData.outdoorModel),
            ),
            ListTile(
              title: Text('Outdoor Model Number'),
              subtitle: Text(formData.outdoorModelNum),
            ),
            ListTile(
              title: Text('Outdoor Serial Number'),
              subtitle: Text(formData.outdoorSerialNum),
            ),
            ListTile(
              title: Text('Outdoor Capacity'),
              subtitle: Text(formData.outdoorCapacity),
            ),
            // Add additional details here
            ListTile(
              title: Text('Additional Field 1'),
              // subtitle: Text(formData.additionalField1),
            ),
            ListTile(
              title: Text('Additional Field 2'),
              // subtitle: Text(formData.additionalField2),
            ),
          ],
        ),
      ),
    );
  }
}
