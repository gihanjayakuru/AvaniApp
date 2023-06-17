import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pwPdfWidgets;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'my_form_screen.dart';
import 'saved_pdf_screen.dart';
import 'service_data.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class PDFGenerator {
  static Future<String?> generatePDF(MergedData serviceFormData) async {
    List<Map<String, dynamic>> serviceImages = await DatabaseHelper.instance
        .getServiceImagesForForm(serviceFormData.id);

    final pdf = pw.Document();

    final combinedPage = pw.Page(
      build: (pw.Context context) {
        final pageWidth = context.page.pageFormat.availableWidth;
        final pageHeight = context.page.pageFormat.availableHeight;
        return pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Text(
              //   'PDF Content',
              //   style: pw.TextStyle(
              //     fontSize: 24,
              //     fontWeight: pw.FontWeight.bold,
              //   ),
              // ),
              // pw.SizedBox(height: 20),
              pw.Text(
                'Location: ${serviceFormData.location}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(height: 10),
              pw.Text(
                'Technician Name : ${serviceFormData.technicianName}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Date created : ${serviceFormData.createdDate}',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(height: 10),
              // pw.SizedBox(height: 20),
              pw.Text(
                'Before Service Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(height: 10),
              pw.Text(
                'Room Temperature : ${serviceFormData.beforeRoomTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Set Point Temperature : ${serviceFormData.beforeSetPointTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Supply Grill Temperature : ${serviceFormData.beforeSupplyGrillTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Return Grill Temperature : ${serviceFormData.beforeReturnGrillTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Gas Pressure /Low Side : ${serviceFormData.beforeGasPressureLowSide}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Gas Pressure /High Side : ${serviceFormData.beforeGasPressureHighSide}',
                style: pw.TextStyle(fontSize: 14),
              ),
              // pw.SizedBox(height: 20),
              pw.Divider(height: 10),
              pw.Text(
                'After Service Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(height: 10),
              pw.Text(
                'Room Temperature : ${serviceFormData.afterRoomTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Set Point Temperature : ${serviceFormData.afterSetPointTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Supply Grill Temperature : ${serviceFormData.afterSupplyGrillTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Return Grill Temperature : ${serviceFormData.afterReturnGrillTemperature}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Gas Pressure /Low Side : ${serviceFormData.afterGasPressureLowSide}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Gas Pressure /High Side : ${serviceFormData.afterGasPressureHighSide}',
                style: pw.TextStyle(fontSize: 14),
              ),
              // pw.SizedBox(height: 20),
              pw.Divider(height: 10),
              pw.Text(
                'Indoor Unit Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(height: 10),
              pw.Text(
                'Blower Check : ${serviceFormData.blowerCheck}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Indoor Inspect Clean IDU Coil Fins : ${serviceFormData.indoorInspectCleanIduCoilFins}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Check Clean Drain Plate : ${serviceFormData.checkCleanDrainPlate}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Drain Pump Check : ${serviceFormData.drainPumpCheck}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Check Piping Duck Insulation : ${serviceFormData.checkPipingDuckInsulation}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Check Noise : ${serviceFormData.checkNoise}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Indoor Housing Condition : ${serviceFormData.indoorHousingCondition}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Indoor PCB Status : ${serviceFormData.indoorPcbStatus}',
                style: pw.TextStyle(fontSize: 14),
              ),
              // pw.SizedBox(height: 20),
              pw.Divider(height: 10),
              pw.Text(
                'Outdoor Unit Details',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              // pw.SizedBox(height: 10),
              pw.Text(
                'Compressor Noise: ${serviceFormData.compressorNoise}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Fan Noise : ${serviceFormData.fanNoise}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Outdoor Inspect Clean IDU Coil Fins : ${serviceFormData.outdoorInspectCleanIduCoilFins}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Outdoor PCB Status : ${serviceFormData.outdoorPcbStatus}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Outdoor Housing Condition : ${serviceFormData.outdoorHousingCondition}',
                style: pw.TextStyle(fontSize: 14),
              ),
              // pw.SizedBox(height: 20),
              pw.Divider(height: 10),
              pw.Text(
                'General',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'AC Sliding Door Operation : ${serviceFormData.acSlidinDoorOperation}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Thermostat Setting : ${serviceFormData.thermostatSetting}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Drain Line Clean : ${serviceFormData.drainLineClean}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Text(
                'Remark : ${serviceFormData.remark}',
                style: pw.TextStyle(fontSize: 14),
              ),
              pw.Divider(height: 10),
            ],
          ),
        );
      },
    );
    // );

    pdf.addPage(combinedPage);

    // pw.Page(build: (pw.Context context) {
    //   return pw.Column(
    //       crossAxisAlignment: pw.CrossAxisAlignment.start, children: [/////////////////////]);
    // });

    // Add a new page to the document
    final page3 = pw.Page(
      build: (pw.Context context) {
        final pageWidth = context.page.pageFormat.availableWidth;
        final pageHeight = context.page.pageFormat.availableHeight;
        final imageWidth = 400.0; // Adjust the width as desired
        final imageHeight = 250.0; // Adjust the height as desired
        final imageX = (pageWidth - imageWidth) / 2;
        final imageY = 200.0; // Adjust the Y position as desired

        return pw.Container(
          child: pw.GridView(
            crossAxisCount: 2, // Number of columns in the grid
            children: [
              for (var imageInfo in serviceImages)
                pw.Container(
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Image(
                    pw.MemoryImage(
                      File(imageInfo['image_path']).readAsBytesSync(),
                    ),
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
            ],
          ),
        );
      },
    );

    // Add the page to the document
    // final outputDir = await getExternalStorageDirectory();
    // final outputDir = await getApplicationDocumentsDirectory();
    // final appFile = File('${outputDir.path}/example.txt');
    // pdf.addPage(page2);
    pdf.addPage(page3);

    // Directory outputDir = Directory('/storage/emulated/0/Download');
    Directory outputDir = await getTemporaryDirectory();

    final pdfDir = Directory(outputDir.path);
    if (!pdfDir.existsSync()) {
      try {
        pdfDir.createSync();
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Failed to create directory.No permission',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return null; // or any default value to indicate the failure
      }
    }
    final now = DateTime.now();
    final formattedDate =
        '${now.year}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}';
    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}_${now.minute.toString().padLeft(2, '0')}_${now.second.toString().padLeft(2, '0')}';
    final fileName = 'report_$formattedDate ($formattedTime)';
    final outputFile = File('${pdfDir.path}/$fileName.pdf');

    try {
      await outputFile.writeAsBytes(await pdf.save());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to save the PDF.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    return outputFile.path;
//////////////////////////
    // Directory outputDir = Directory('/storage/emulated/0/Download');
    // Directory outputDir = await getTemporaryDirectory();

    // final pdfDir = Directory(outputDir.path);
    // if (!pdfDir.existsSync()) {
    //   pdfDir.createSync();
    // }
    // final now = DateTime.now();
    // final formattedDate =
    //     '${now.year}_${now.month.toString().padLeft(2, '0')}_${now.day.toString().padLeft(2, '0')}';
    // final formattedTime =
    //     '${now.hour.toString().padLeft(2, '0')}_${now.minute.toString().padLeft(2, '0')}_${now.second.toString().padLeft(2, '0')}';
    // final fileName = 'report_$formattedDate ($formattedTime)';
    // final outputFile = File('${pdfDir.path}/$fileName.pdf');
    // await outputFile.writeAsBytes(await pdf.save());

    // return outputFile.path;
  }
}

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

  // void _loadServiceFormData() async {
  //   List<Map<String, dynamic>> serviceFormDataList =
  //       await DatabaseHelper.instance.getServiceFormDataList();

  //   savedServiceFormData = serviceFormDataList
  //       .map((formData) => MergedData.fromJson(formData))
  //       .toList();

  //   setState(() {});
  // }
  void _loadServiceFormData() async {
    List<Map<String, dynamic>> serviceFormDataList =
        await DatabaseHelper.instance.getServiceFormDataList();

    savedServiceFormData = serviceFormDataList
        .map((formData) => MergedData.fromJson(formData))
        .toList();

    if (selectedDateFilter != null) {
      savedServiceFormData = savedServiceFormData.where((data) {
        DateTime createdDate = DateTime.parse(data.createdDate);
        return createdDate.year == selectedDateFilter!.year &&
            createdDate.month == selectedDateFilter!.month &&
            createdDate.day == selectedDateFilter!.day;
      }).toList();
    }

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
                Text('Blower Check : ${serviceFormData.blowerCheck}'),
                Divider(),
                Text(
                    'Indoor Inspect Clean IDU Coil Fins : ${serviceFormData.indoorInspectCleanIduCoilFins}'),
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

  void filterDataByDate(DateTime selectedDate) {
    setState(() {
      selectedDateFilter = selectedDate;
    });
  }

  // Function to filter data based on selected date
  // List<MergedData> filterDataByDate(DateTime selectedDate) {
  //   List<MergedData> filteredList = savedServiceFormData.where((formData) {
  //     DateTime? formDataDate =
  //         DateFormat("yyyy-MM-dd").parse(formData.createdDate);
  //     return formDataDate != null &&
  //         formDataDate.year == selectedDate.year &&
  //         formDataDate.month == selectedDate.month &&
  //         formDataDate.day == selectedDate.day;
  //   }).toList();

  //   return filteredList;
  // }

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
    // Apply date filter
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDateFilter ?? DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  setState(() {
                    selectedDateFilter = selectedDate;
                  });
                  _loadServiceFormData();
                }
              },
              child: Text('Select Date'),
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
            label: 'Add Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: 'Select Locations',
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
    String? pdfPath = await PDFGenerator.generatePDF(serviceFormData);

    if (pdfPath != null) {
      // Save the PDF path in the database
      await DatabaseHelper.instance.savePDFPath(pdfPath);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to generate the PDF.No path rec',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
  // void _generatePDF(MergedData serviceFormData) async {
  //   String pdfPath = await PDFGenerator.generatePDF(serviceFormData);

  //   //pass to databese to save path in table
  //   await DatabaseHelper.instance.savePDFPath(pdfPath);

  //   // savedPDFs.add(pdfPath);
  //   // setState(() {});

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
  //   );
  // }
}
