import 'package:avani_app/service_list.dart';
import 'package:flutter/material.dart';
import 'package:avani_app/list_screen.dart';

class ServiceFormScreen extends StatefulWidget {
  final FormData formData;

  ServiceFormScreen({required this.formData});

  @override
  _ServiceFormScreenState createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    serviceTypeController.dispose();
    serviceDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: serviceTypeController,
                  decoration: InputDecoration(labelText: 'Service Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the service type';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: serviceDescriptionController,
                  decoration: InputDecoration(labelText: 'Service Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the service description';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _saveServiceForm();
                    }
                  },
                  child: Text('Save Service'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveServiceForm() async {
    String serviceType = serviceTypeController.text;
    String serviceDescription = serviceDescriptionController.text;
    // Get the current date and time
    DateTime now = DateTime.now();

    // Create a map of the service form data
    Map<String, dynamic> serviceFormData = {
      'serviceType': serviceType,
      'serviceDescription': serviceDescription,
      'createdDate': now.toIso8601String(),
    };

    // Save the service form data to a separate table or storage
    // Here, you can use a database or any other storage mechanism to save the data.

    // After saving the data, navigate to the ServiceListScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ServiceListScreen(serviceDetails: [serviceFormData]),
      ),
    );
  }
}
