import 'dart:io';

import 'package:avani_app/additional_details_screen.dart';
import 'package:flutter/material.dart';
import 'form_data.dart';
import 'service_list.dart';
import 'database_helper.dart';

class LocationListScreen extends StatefulWidget {
  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<FormData> savedFormData = [];
  FormData? selectedFormData;
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  @override
  void dispose() {
    // Close the database connection
    DatabaseHelper.instance.closeDatabase();
    super.dispose();
  }

  void _loadFormData() async {
    List<Map<String, dynamic>> formDataList =
        await DatabaseHelper.instance.getFormDataList();

    savedFormData = formDataList.map((formDataMap) {
      return FormData(
        id: formDataMap['id'],
        location: formDataMap['location'],
        ///////
        indoorModel: formDataMap['indoorModel'],
        indoorModelNum: formDataMap['indoorModelNum'],
        indoorSerialNum: formDataMap['indoorSerialNum'],
        indoorCapacity: formDataMap['indoorCapacity'],
        //////
        outdoorModel: formDataMap['outdoorModel'],
        outdoorModelNum: formDataMap['outdoorModelNum'],
        outdoorSerialNum: formDataMap['outdoorSerialNum'],
        outdoorCapacity: formDataMap['outdoorCapacity'],
      );
    }).toList();

    setState(() {
      // Trigger a rebuild to display the retrieved data
    });
  }

  void _deleteFormData(FormData formData) async {
    await DatabaseHelper.instance.deleteFormData(formData.id);

    setState(() {
      savedFormData.remove(formData);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // void _deleteFormData(FormData formData) async {
  //   bool success = await DatabaseHelper.instance.deleteFormData(formData.id);
  //   if (success) {
  //     setState(() {
  //       savedFormData.remove(formData);
  //     });
  //     // Show a success message or perform any other necessary actions
  //   } else {
  //     // Show an error message or perform any other necessary actions
  //   }
  // }

//
  void _showDetailsDialog(
      BuildContext context, FormData formData, int index) async {
    final databaseHelper = DatabaseHelper.instance;
    final imagePath = await databaseHelper.getImagePathForForm(formData.id);

    print('image ID load in: ${formData.id}');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Details :'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Location :'),
                  subtitle: Text(formData.location ?? ''),
                ),
                Divider(),
                if (imagePath != null && File(imagePath).existsSync())
                  Image.file(
                      File(imagePath)), // Show the image using the file path
                if (imagePath == null || !File(imagePath).existsSync())
                  Text('Image not found !'),
                ////////////////////indoor//////////////////////
                ///
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Indoor Unit :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('indoor Model :'),
                  subtitle: Text(formData.indoorModel ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('indoor Model Num :'),
                  subtitle: Text(formData.indoorModelNum ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('indoor Serial Num :'),
                  subtitle: Text(formData.indoorSerialNum ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('indoor Capacity :'),
                  subtitle: Text(formData.indoorCapacity ?? ''),
                ),
                Divider(),
////////////////////////////Outdoor unit//////////////////////////////
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
                ListTile(
                  title: Text('out door Model :'),
                  subtitle: Text(formData.outdoorModel ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Model Num :'),
                  subtitle: Text(formData.outdoorModelNum ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Serial Num :'),
                  subtitle: Text(formData.outdoorSerialNum ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Capacity :'),
                  subtitle: Text(formData.outdoorCapacity ?? ''),
                ),
                Divider(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdditionalDetailsScreen(
                      formData: formData,
                    ),
                  ),
                );
              },
              child: Text('ADD Service'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FormData> filteredFormData = savedFormData.where((formData) {
      final location = formData.location?.toLowerCase() ?? '';
      final query = _searchController.text.toLowerCase();
      return location.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Location List Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by location',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  // Trigger a rebuild to apply the search filter
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFormData.length,
              itemBuilder: (context, index) {
                FormData formData = filteredFormData[index];
                return buildCard(context, formData, index, databaseHelper);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ServiceListScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Add Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Location List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Service List',
          ),
        ],
      ),
    );
  }

  Widget buildCard(
    BuildContext context,
    FormData formData,
    int index,
    DatabaseHelper databaseHelper,
  ) {
    return Card(
      child: ListTile(
        onTap: () {
          _showDetailsDialog(context, formData, index);
        },
        title: Text('location : ${formData.location ?? ''}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('indoorModel : ${formData.indoorModel ?? ''}'),
            Text('outdoorModel : ${formData.outdoorModel}'),
            // Text('technicianName : ${formData. ?? ''}'),
          ],
        ),
        leading: FutureBuilder<String?>(
          future: databaseHelper.getImagePathForForm(formData.id),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while fetching image path
            } else if (snapshot.hasError || snapshot.data == null) {
              return Icon(Icons
                  .image_not_supported); // Show default icon if image path is not available
            } else {
              final imagePath = snapshot.data!;
              if (File(imagePath).existsSync()) {
                return Image.file(
                  File(imagePath),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ); // Show the image using the file path
              } else {
                return Icon(Icons
                    .image_not_supported); // Show default icon if image file does not exist
              }
            }
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _deleteFormData(formData);
          },
        ),
      ),
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   List<FormData> filteredFormData = savedFormData.where((formData) {
  //     final location = formData.location?.toLowerCase() ?? '';
  //     final query = _searchController.text.toLowerCase();
  //     return location.contains(query);
  //   }).toList();

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Location List Screen'),
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: TextField(
  //             controller: _searchController,
  //             decoration: InputDecoration(
  //               labelText: 'Search by location',
  //               prefixIcon: Icon(Icons.search),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 // Trigger a rebuild to apply the search filter
  //               });
  //             },
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: filteredFormData.length,
  //             itemBuilder: (context, index) {
  //               FormData formData = filteredFormData[index];
  //               return Card(
  //                 child: ListTile(
  //                   onTap: () {
  //                     _showDetailsDialog(context, formData, index);
  //                   },
  //                   title: Text('location: ${formData.location ?? ''}'),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text('Created: ${formData.date ?? ''}'),
  //                       Text('id: ${formData.id}'),
  //                       Text(
  //                           'technicianName: ${formData.technicianName ?? ''}'),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: 1,
  //       onTap: (int index) {
  //         if (index == 0) {
  //           Navigator.popUntil(context, (route) => route.isFirst);
  //         } else if (index == 2) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => ServiceListScreen()),
  //           );
  //         }
  //       },
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.list),
  //           label: 'LocationList',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.list),
  //           label: 'ServiceList',
  //         ),
  //       ],
  //     ),
  //   );
  // }
// }
