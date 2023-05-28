import 'package:avani_app/service_list.dart';
import 'package:flutter/material.dart';
import 'databse_helper2.dart';
import 'form_data.dart';
import 'location_list.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  final FormData formData;

  AdditionalDetailsScreen({required this.formData});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  // Define controllers for text fields
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of controllers
    serviceTypeController.dispose();
    serviceDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationListScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Location: ${widget.formData.location}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Service:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: serviceTypeController,
                      decoration: InputDecoration(labelText: 'Service Type'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the service type';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: serviceDescriptionController,
                      decoration:
                          InputDecoration(labelText: 'Service Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the service description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              // Form is valid, save the data
              _saveForm();
            }
          },
          child: Text('Save'),
        ),
      ),
    );
  }

  void _saveForm() async {
    // Retrieve the form field values using the controllers
    String location = widget.formData.location ?? '';
    String serviceType = serviceTypeController.text;
    String serviceDescription = serviceDescriptionController.text;

    // Get the current date and time
    DateTime now = DateTime.now();

    // Create a map of the form data
    Map<String, dynamic> serviceFormData = {
      'location': location,
      'serviceType': serviceType,
      'serviceDescription': serviceDescription,
      'createdDate': now.toIso8601String(),
    };

    // Save the form data using your existing DatabaseHelper class
    await DatabaseHelper.instance.insertServiceFormData(serviceFormData);

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ServiceListScreen()),
    );
  }
}
