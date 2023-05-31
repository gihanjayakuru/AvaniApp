import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

//TO DO
// remove top photo and add 1 photo to indoor unit and another to outdoor

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

  // File? _image;
  File? _indoorImage;
  File? _outdoorImage;

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
              ////
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Indoor unit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200, // Adjust the height as per your requirement
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black),
                      ),
                      child: _indoorImage != null
                          ? Image.file(_indoorImage!, fit: BoxFit.cover)
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
                              _indoorImage = null;
                            });
                            _openIndoorImagePicker();
                          },
                          child: const Text('Add Indoor Image'),
                        ),
                      ),
                    ),
                  ],
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
                      controller: indoorSerialNumController,
                      decoration:
                          InputDecoration(labelText: 'indoor Serial Num :'),
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
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Outdoor unit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 200,
                            height:
                                200, // Adjust the height as per your requirement
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.black),
                            ),
                            child: _outdoorImage != null
                                ? Image.file(_outdoorImage!, fit: BoxFit.cover)
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
                                    _outdoorImage = null;
                                  });
                                  _openOutdoorImagePicker();
                                },
                                child: const Text('Add Outdoor Image'),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Future<void> _openIndoorImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _indoorImage = File(pickedImage.path);
        print('woooooooo indoor image :${_indoorImage}');
      });
    }
  }

  Future<void> _openOutdoorImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _outdoorImage = File(pickedImage.path);
        print('woooooooo outdoor image :${_outdoorImage}');
      });
    }
  }

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

    bool isIndoorImageSaved;
    // bool isOutdoorImageSaved = true;

    // if (_indoorImage != null) {
    //   isIndoorImageSaved =
    //       await DatabaseHelper.instance.saveImages(id, _indoorImage!, null);
    // }

    // print('Indoor image file path: ${_indoorImage.path}');
    isIndoorImageSaved = await DatabaseHelper.instance
        .saveImages(id, _indoorImage, _outdoorImage);

    //   isOutdoorImageSaved =
    //       await DatabaseHelper.instance.saveImages(id, , _outdoorImage!);
    // }
    // print('checkings...... indor  :${isIndoorImageSaved}');
    // print('checkings......  out :${isOutdoorImageSaved}');

    if (isIndoorImageSaved) {
      // Images were inserted successfully
      print('2 Images were inserted successfully');
    } else {
      // Image insertion failed
      print('2 Images insertion failed');
    }

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
