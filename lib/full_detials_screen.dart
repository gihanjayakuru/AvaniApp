import 'package:flutter/material.dart';

import 'form_data.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Location: ${formData.location}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Indoor Model: ${formData.indoorModel}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Indoor Model Number: ${formData.indoorModelNum}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Indoor Serial Number: ${formData.indoorSerialNum}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Indoor Capacity: ${formData.indoorCapacity}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Outdoor Model: ${formData.outdoorModel}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Outdoor Model Number: ${formData.outdoorModelNum}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Outdoor Serial Number: ${formData.outdoorSerialNum}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Outdoor Capacity: ${formData.outdoorCapacity}',
                style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Created Date: ${formData.createdDate}',
                style: TextStyle(fontSize: 18)),
          ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text('Additional Field 1: ${formData.additionalField1}',
          //       style: TextStyle(fontSize: 18)),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text('Additional Field 2: ${formData.additionalField2}',
          //       style: TextStyle(fontSize: 18)),
          // ),
        ],
      ),
    );
  }
}
