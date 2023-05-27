import 'package:avani_app/service_list.dart';
import 'package:flutter/material.dart';
import 'package:avani_app/form_data.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  final FormData formData;

  AdditionalDetailsScreen({required this.formData});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  TextEditingController _additionalFieldController = TextEditingController();

  @override
  void dispose() {
    _additionalFieldController.dispose();
    super.dispose();
  }

  // void _saveAdditionalDetails() {
  //   String additionalField = _additionalFieldController.text;

  //   // Merge the past details with the new additional details
  //   Map<String, dynamic> mergedData = {
  //     'location': widget.formData.location,
  //     'additionalDetails': additionalField,
  //     'createdDate': widget.formData.createdDate,
  //   };

  //   // Pass the merged data back to the previous screen
  //   Navigator.pop(context, mergedData);
  // }
  void _saveAdditionalDetails() {
    String additionalField = _additionalFieldController.text;

    // Merge the past details with the new additional details
    Map<String, dynamic> mergedData = {
      'location': widget.formData.location,
      'additionalDetails': additionalField,
      'createdDate': widget.formData.createdDate,
    };

    // Pass the merged data to the ServiceListScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceListScreen(
          mergedFormDataList: [mergedData],
          serviceDetails: [], // Provide service details as needed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Details vvvvv'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Location: ${widget.formData.location}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _additionalFieldController,
              decoration: InputDecoration(
                labelText: 'Additional Field',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveAdditionalDetails,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
