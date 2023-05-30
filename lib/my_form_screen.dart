import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  // Define controllers for text fields
  TextEditingController locationController = TextEditingController();

  TextEditingController indoorModelController = TextEditingController();
  TextEditingController indoorModelNumController = TextEditingController();
  TextEditingController indoorSerialNumController = TextEditingController();
  TextEditingController indoorCapacityController = TextEditingController();

  TextEditingController outdoorModelController = TextEditingController();
  TextEditingController outdoorModelNumController = TextEditingController();
  TextEditingController outdoorSerialNumController = TextEditingController();
  TextEditingController outdoorCapacityController = TextEditingController();

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  // Variables for handling image
  String imagePath = '';
  // Variables for handling image
  // File? imageFile;

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();

  @override
  void dispose() {
    // Dispose of controllers
    locationController.dispose();

    indoorModelController.dispose();
    indoorModelNumController.dispose();
    indoorSerialNumController.dispose();
    indoorCapacityController.dispose();

    outdoorModelController.dispose();
    outdoorModelNumController.dispose();
    outdoorSerialNumController.dispose();
    outdoorCapacityController.dispose();
    //////////////////////////////////////////////
    super.dispose();
  }

  // void _resetImage() {
  //   setState(() {
  //     imageFile = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Get the current date
    // DateTime now = DateTime.now();

// Format the current date
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // // Set the formatted date as the initial value for the dateController
    // dateController.text = formattedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Form'),
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
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Container(
                      height: 200, // Adjust the height as per your requirement
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black),
                      ),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.grey[300],
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                            _openImagePicker();
                          },
                          child: const Text('Add Image'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: indoorModelController,
                      decoration: InputDecoration(labelText: 'indoor Model :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor Model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorModelNumController,
                      decoration:
                          InputDecoration(labelText: 'indoor Model Number :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor Model Num';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorSerialNumController,
                      decoration:
                          InputDecoration(labelText: 'outdoor Serial Num :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outdoor Serial Num';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorCapacityController,
                      decoration:
                          InputDecoration(labelText: 'indoor Capacity :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter indoor Capacity';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorModelController,
                      decoration: InputDecoration(labelText: 'outdoor Model :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outdoor Model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorModelNumController,
                      decoration:
                          InputDecoration(labelText: 'outdoor Model Num :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outdoor Model Num';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorSerialNumController,
                      decoration:
                          InputDecoration(labelText: 'outdoor Serial Num :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outdoor Serial Num';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorCapacityController,
                      decoration:
                          InputDecoration(labelText: 'outdoor Capacity :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter outdoor Capacity';
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

  // void _selectImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       imageFile = File(pickedImage.path);
  //     });
  //   }
  // }

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Future<void> _openImagePickerCamera() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //     });
  //   }
  // }

  void _saveForm() async {
    // Retrieve the form field values using the controllers
    String location = locationController.text;
    String indoorModel = indoorModelController.text;
    String indoorModelNum = indoorModelNumController.text;
    String indoorSerialNum = indoorSerialNumController.text;
    String indoorCapacity = indoorCapacityController.text;

    String outdoorModel = outdoorModelController.text;
    String outdoorModelNum = outdoorModelNumController.text;
    String outdoorSerialNum = outdoorSerialNumController.text;
    String outdoorCapacity = outdoorCapacityController.text;

    // Create a map of the form data
    Map<String, dynamic> formData = {
      'location': location,
      'indoorModel': indoorModel,
      'indoorModelNum': indoorModelNum,
      'indoorSerialNum': indoorSerialNum,
      'indoorCapacity': indoorCapacity,
      'outdoorModel': outdoorModel,
      'outdoorModelNum': outdoorModelNum,
      'outdoorSerialNum': outdoorSerialNum,
      'outdoorCapacity': outdoorCapacity,
    };

    // Save the form data in SQLite
    int id = await DatabaseHelper.instance.insertFormData(formData);
    print('Form data saved with ID: $id');

    final isImageSaved = await DatabaseHelper.instance.saveImage(id, _image!);
    if (isImageSaved) {
      // Image data was inserted successfully
      print(' Image data was inserted successfully');
    } else {
      // Image data insertion failed
      print('Image data insertion failed');
    }
// // Save the image file
//     if (imageFile != null) {
//       await DatabaseHelper.instance.saveImage(id, imageFile!);
//       print('Image saved for form ID: $id');
//     }
    // Clear the form fields
    _clearForm();

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationListScreen()),
    );
  }

  void _clearForm() {
    locationController.clear();
    indoorModelController.clear();
    indoorModelNumController.clear();
    indoorSerialNumController.clear();
    indoorCapacityController.clear();

    outdoorModelController.clear();
    outdoorModelNumController.clear();
    outdoorSerialNumController.clear();
    outdoorCapacityController.clear();
  }
}
