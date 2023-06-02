import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:avani_app/saved_pdf_screen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'my_form_screen.dart';
import 'service_data.dart';
import 'package:pdf/widgets.dart' as pwLib;

// import 'package:pdf/widgets.dart' show PdfPageFormat, PdfImage;

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class PDFGenerator {
  static Future<String> generatePDF(MergedData serviceFormData) async {
    List<Map<String, dynamic>> serviceImages = await DatabaseHelper.instance
        .getServiceImagesForForm(serviceFormData.id);

    final pdf = pwLib.Document();
    // List<Map<String, dynamic>> serviceImages = await DatabaseHelper.instance
    //     .getServiceImagesForForm(serviceFormData.id);
    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'PDF Content',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Location: ${serviceFormData.location}',
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Date: ${serviceFormData.createdDate}',
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Before After Service Details',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Room Temperature: ${serviceFormData.beforeRoomTemperature}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.Divider(height: 10),
                pw.Text(
                  'Set Point Temperature: ${serviceFormData.beforeSetPointTemperature}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // Add more details here for Before Service

                pw.SizedBox(height: 20),
                pw.Text(
                  'After Service',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Room Temperature: ${serviceFormData.afterRoomTemperature}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // Add more details here for After Service

                pw.SizedBox(height: 20),
                pw.Text(
                  'Indoor Unit',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Blower Check: ${serviceFormData.blowerCheck}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // Add more details here for Indoor Unit

                pw.SizedBox(height: 20),
                pw.Text(
                  'Outdoor Unit',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Compressor Noise: ${serviceFormData.compressorNoise}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // Add more details here for Outdoor Unit

                pw.SizedBox(height: 20),
                pw.Text(
                  'General',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'AC Sliding Door Operation: ${serviceFormData.acSlidinDoorOperation}',
                  style: pw.TextStyle(fontSize: 14),
                ),
                // Add more details here for General
                // pw.SizedBox(height: 10),
                _buildImageSection(serviceImages),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF to a file
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'service_form_$timestamp.pdf';
    final appDocDir = await getApplicationDocumentsDirectory();
    final downloadDirectory = Directory('${appDocDir.path}/Download');
    await downloadDirectory.create(recursive: true);
    final outputFile = File('${downloadDirectory.path}/$fileName');
    await outputFile.writeAsBytes(await pdf.save());

    print('path PDF ::=====${outputFile.path}');

    return outputFile.path;
  }
}

pw.Widget _buildImageSection(List<Map<String, dynamic>> serviceImages) {
  if (serviceImages.isNotEmpty) {
    print(
        'Images not empty in _buildImageSection??????????------------------////////${serviceImages}');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        pw.Text(
          'Images',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: serviceImages.map((imageData) {
            final String imagePath = imageData['image_path'];

            print(
                'heeeeeeeeeeeeeeeeeeeeeeeeeedsadads========/////${imagePath}');
            final imageFile = File(imagePath);
            if (imageFile.existsSync()) {
              print('image file loadin.....................////');
              final imageBytes = imageFile.readAsBytesSync();
              final imageProvider = pw.MemoryImage(imageBytes);
              return pw.Image(imageProvider);
            } else {
              print('no image file loding------');
              return pw.Container(); // Empty container if file does not exist
            }
          }).toList(),
        ),
      ],
    );
  } else {
    return pw.Container();
  }
}

// pw.Widget _buildImageSection(List<Map<String, dynamic>> serviceImages) {
//   if (serviceImages.isNotEmpty) {
//     print(
//         'Images not empty in _buildImageSection/////////////////////////------');
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pwLib.SizedBox(height: 20),
//         pwLib.Text(
//           'Images',
//           style: pwLib.TextStyle(
//             fontSize: 18,
//             fontWeight: pwLib.FontWeight.bold,
//           ),
//         ),
//         pwLib.SizedBox(height: 10),
//         pwLib.Wrap(
//           spacing: 8.0,
//           runSpacing: 8.0,
//           children: serviceImages.map((image) {
//             if (image != null && image['image_data'] != null) {
//               final List<int> imageData = List<int>.from(image['image_data']);

//               final imageProvider =
//                   pwLib.MemoryImage(Uint8List.fromList(imageData));
//               return pwLib.Image(imageProvider);
//             }
//             return pwLib.Container();
//           }).toList(),
//         ),
//       ],
//     );
//   } else {
//     return pwLib.Container();
//   }
// }

class _ServiceListScreenState extends State<ServiceListScreen> {
  // List<MergedData> savedServiceFormData = [];
  String searchQuery = '';
  // late DateTime selectedDateFilter;
  List<MergedData> savedServiceFormData = [];
  DateTime? selectedDateFilter; // Initialize to null

  List<String> savedPDFs = [];

  @override
  void initState() {
    super.initState();
    _loadServiceFormData();
  }

  @override
  void dispose() {
    // Close the database connection
    DatabaseHelper.instance.closeDatabase();
    super.dispose();
  }

  void _loadServiceFormData() async {
    List<Map<String, dynamic>> serviceFormDataList =
        await DatabaseHelper.instance.getServiceFormDataList();

    savedServiceFormData = serviceFormDataList
        .map((formData) => MergedData.fromJson(formData))
        .toList();

    setState(() {});
  }

  void _deleteServiceFormData(int id) async {
    await DatabaseHelper.instance.deleteServiceFormData(id);

    _loadServiceFormData();
  }

  void _showServiceDetailsDialog(MergedData serviceFormData, context) async {
    List<Map<String, dynamic>> serviceImages = await DatabaseHelper.instance
        .getServiceImagesForForm(serviceFormData.id);

    print("Service list load with this id${serviceFormData.id}");

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Before After Service Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location : ${serviceFormData.location}'),
                Text('Date : ${serviceFormData.createdDate}'),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Before Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Room Temperature : ${serviceFormData.beforeRoomTemperature}'),
                Divider(),
                Text(
                    'Set Point Temperature : ${serviceFormData.beforeSetPointTemperature}'),
                Divider(),
                Text(
                    'Supply Grill Temperature : ${serviceFormData.beforeSupplyGrillTemperature}'),
                Divider(),
                Text(
                    'Return Grill Temperature : ${serviceFormData.beforeReturnGrillTemperature}'),
                Divider(),
                Text(
                    'Gas Pressure /Low Side : ${serviceFormData.beforeGasPressureLowSide}'),
                Divider(),
                Text(
                    'Gas Pressure /High Side : ${serviceFormData.beforeGasPressureHighSide}'),
                Divider(),
                Text('Amp : ${serviceFormData.beforeAmp}'),
                Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'After Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Room Temperature : ${serviceFormData.afterRoomTemperature}'),
                Divider(),
                Text(
                    'Set Point Temperature : ${serviceFormData.afterSetPointTemperature}'),
                Divider(),
                Text(
                    'Supply Grill Temperature : ${serviceFormData.afterSupplyGrillTemperature}'),
                Divider(),
                Text(
                    'Return Grill Temperature : ${serviceFormData.afterReturnGrillTemperature}'),
                Divider(),
                Divider(),
                Text(
                    'Gas Pressure /Low Side: ${serviceFormData.afterGasPressureLowSide}'),
                Divider(),
                Text(
                    'Gas Pressure /High Side : ${serviceFormData.afterGasPressureHighSide}'),
                Divider(),
                Text('Amp : ${serviceFormData.afterAmp}'),
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
                Text('blower Check : ${serviceFormData.blowerCheck}'),
                Divider(),
                Text(
                    'indoor Inspect Clean IDU Coil Fins : ${serviceFormData.indoorInspectCleanIduCoilFins}'),
                Divider(),
                Text(
                    'Check Clean Drain Plate : ${serviceFormData.checkCleanDrainPlate}'),
                Divider(),
                Text('Drain Pump Check : ${serviceFormData.drainPumpCheck}'),
                Divider(),
                Text(
                    'Check Piping Duck Insulation : ${serviceFormData.checkPipingDuckInsulation}'),
                Divider(),
                Text('Check Noise : ${serviceFormData.checkNoise}'),
                Divider(),
                Text(
                    'Indoor Housing Condition : ${serviceFormData.indoorHousingCondition}'),
                Divider(),
                Text('Indoor PCB Status : ${serviceFormData.indoorPcbStatus}'),
                Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Outdoor Unit :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Compressor Noise : ${serviceFormData.compressorNoise}'),
                Divider(),
                Text('Fan Noise : ${serviceFormData.fanNoise}'),
                Divider(),
                Text(
                    'Outdoor Inspect Clean IDU Coil Fins : ${serviceFormData.outdoorInspectCleanIduCoilFins}'),
                Divider(),
                Text(
                    'Outdoor PCB Status : ${serviceFormData.outdoorPcbStatus}'),
                Divider(),
                Text(
                    'Outdoor Housing Condition : ${serviceFormData.outdoorHousingCondition}'),
                Divider(),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'General :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'AC Sliding Door Operation : ${serviceFormData.acSlidinDoorOperation}'),
                Divider(),
                Text(
                    'Thermostat Setting : ${serviceFormData.thermostatSetting}'),
                Divider(),
                Text('Drain Line Clean : ${serviceFormData.drainLineClean}'),
                Divider(),
                Text('Remark : ${serviceFormData.remark}'),
                Divider(),
                Text('Date : ${serviceFormData.date}'),
                Divider(),
                Text('Technician Name : ${serviceFormData.technicianName}'),
                Divider(),
                if (serviceImages.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Service Images',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (serviceImages.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: serviceImages.map((imageData) {
                      final String imagePath = imageData['image_path'];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(imagePath), fit: BoxFit.cover),
                      );
                    }).toList(),
                  ),
                if (serviceImages.isEmpty) Text('No images available'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Save PDF'),
              onPressed: () {
                _generatePDF(serviceFormData);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<MergedData> _filteredServiceFormData() {
    List<MergedData> filteredList = savedServiceFormData;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((formData) {
        String location = formData.location.toLowerCase();
        String date = formData.createdDate.toLowerCase();
        return location.contains(searchQuery.toLowerCase()) ||
            date.contains(searchQuery.toLowerCase());
      }).toList();
    }
    // Filter by date
    if (selectedDateFilter != null) {
      filteredList = filteredList.where((formData) {
        DateTime? date = DateFormat("yyyy-MM-dd").parse(formData.createdDate);
        return date != null &&
            date.year == selectedDateFilter!.year &&
            date.month == selectedDateFilter!.month &&
            date.day == selectedDateFilter!.day;
      }).toList();
    }

    return filteredList; // Add a return statement here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedServiceFormData.length,
              itemBuilder: (context, index) {
                MergedData serviceFormData = savedServiceFormData[index];
                if (serviceFormData.location
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())) {
                  return Card(
                    child: ListTile(
                      title: Text(serviceFormData.location),
                      subtitle: Text(serviceFormData.createdDate),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              _showServiceDetailsDialog(
                                  serviceFormData, context);
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteServiceFormData(serviceFormData.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              _generatePDF(serviceFormData);
                            },
                            icon: Icon(Icons.picture_as_pdf),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set the index of the current page
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyFormScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationListScreen()),
            );
          } else if (index == 2) {
            // Stay on the service list page
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
            );
          }
        },
        selectedItemColor: Colors.blue, // Color of the selected button
        unselectedItemColor: Colors.grey, // Color of the unselected buttons
        backgroundColor:
            Colors.white, // Background color of the bottom navigation bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: 'Add Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Service List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'Saved PDFs',
          ),
        ],
      ),
    );
  }

  void _generatePDF(MergedData serviceFormData) async {
    String pdfPath = await PDFGenerator.generatePDF(serviceFormData);

    //pass to databese to save path in table
    await DatabaseHelper.instance.savePDFPath(pdfPath);
    savedPDFs.add(pdfPath);
    setState(() {});

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
    );
  }
}
