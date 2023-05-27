import 'package:flutter/material.dart';

import 'full_detials_screen.dart';
import 'list_screen.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  final FormData formData;

  AdditionalDetailsScreen({required this.formData});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  TextEditingController _additionalField1Controller = TextEditingController();
  TextEditingController _additionalField2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the additional field values if needed
  }

  @override
  void dispose() {
    _additionalField1Controller.dispose();
    _additionalField2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Details'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _additionalField1Controller,
            decoration: InputDecoration(labelText: 'Additional Field 1'),
          ),
          TextField(
            controller: _additionalField2Controller,
            decoration: InputDecoration(labelText: 'Additional Field 2'),
          ),
          ElevatedButton(
            onPressed: () {
              // Save the additional details
              String additionalField1 = _additionalField1Controller.text;
              String additionalField2 = _additionalField2Controller.text;
              // Perform any desired action with the additional details
              // You can save the details, update the existing FormData object, or use a separate data structure

              Navigator.pop(context); // Go back to the previous screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullDetailsScreen(formData: widget.formData),
                ),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
