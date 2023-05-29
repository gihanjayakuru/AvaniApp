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
        filterClean: formDataMap['filterClean'],
        blowerCheck: formDataMap['blowerCheck'],
        indoorInspectCleanIduCoilFins:
            formDataMap['indoorInspectCleanIduCoilFins'],
        checkCleanDrainPlate: formDataMap['checkCleanDrainPlate'],
        drainPumpCheck: formDataMap['drainPumpCheck'],
        checkPipingDuckInsulation: formDataMap['checkPipingDuckInsulation'],
        checkNoise: formDataMap['checkNoise'],
        indoorHousingCondition: formDataMap['indoorHousingCondition'],
        indoorPcbStatus: formDataMap['indoorPcbStatus'],
        //////////////////////////////////////////////
        compressorNoise: formDataMap['compressorNoise'],
        fanNoise: formDataMap['fanNoise'],
        outdoorInspectCleanIduCoilFins:
            formDataMap['outdoorInspectCleanIduCoilFins'],
        outdoorPcbStatus: formDataMap['outdoorPcbStatus'],
        outdoorHousingCondition: formDataMap['outdoorHousingCondition'],
        ///////////////////////////////////////////
        acSlidinDoorOperation: formDataMap['acSlidinDoorOperation'],
        thermostatSetting: formDataMap['thermostatSetting'],
        drainLineClean: formDataMap['drainLineClean'],
        /////////////////////////////////////////////
        remark: formDataMap['remark'],
        date: formDataMap['date'],
        technicianName: formDataMap['technicianName'],
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
          title: Text('Location Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Location'),
                  subtitle: Text(formData.location ?? ''),
                ),
                Divider(),
                if (imagePath != null && File(imagePath).existsSync())
                  Image.file(
                      File(imagePath)), // Show the image using the file path
                if (imagePath == null || !File(imagePath).existsSync())
                  Text('Image not found'),
                ////////////////////indoor//////////////////////
                ///
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
                ListTile(
                  title: Text('Filter Clean'),
                  subtitle: Text(formData.filterClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Blower Check'),
                  subtitle: Text(formData.blowerCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Inspect Clean IDU Coil Fins'),
                  subtitle: Text(formData.indoorInspectCleanIduCoilFins ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Clean Drain Plate'),
                  subtitle: Text(formData.checkCleanDrainPlate ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Drain Pump Check'),
                  subtitle: Text(formData.drainPumpCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Piping Duck Insulation'),
                  subtitle: Text(formData.checkPipingDuckInsulation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Noise'),
                  subtitle: Text(formData.checkNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Indoor Housing Condition'),
                  subtitle: Text(formData.indoorHousingCondition ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('PCB Status'),
                  subtitle: Text(formData.indoorPcbStatus ?? ''),
                ),
                Divider(),
                //////////////////////////outdoor//////////////////////////////
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
                  title: Text('compressor Noise'),
                  subtitle: Text(formData.compressorNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('fan Noise'),
                  subtitle: Text(formData.fanNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Inspect Clean Idu Coil Fins'),
                  subtitle: Text(formData.outdoorInspectCleanIduCoilFins ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Pcb Status'),
                  subtitle: Text(formData.outdoorPcbStatus ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('outdoor Housing Condition'),
                  subtitle: Text(formData.outdoorHousingCondition ?? ''),
                ),
                Divider(),
                //////////////////////////General///////////////////////////////
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'General',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('ac Slidin Door Operation'),
                  subtitle: Text(formData.acSlidinDoorOperation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('thermostat Setting'),
                  subtitle: Text(formData.thermostatSetting ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('drain Line Clean'),
                  subtitle: Text(formData.drainLineClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Remark'),
                  subtitle: Text(formData.remark ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Date'),
                  subtitle: Text(formData.date ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Technician Name'),
                  subtitle: Text(formData.technicianName ?? ''),
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
              child: Text('ADD'),
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
        title: Text('location: ${formData.location ?? ''}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Created: ${formData.date ?? ''}'),
            Text('id: ${formData.id}'),
            Text('technicianName: ${formData.technicianName ?? ''}'),
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
