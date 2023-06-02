import 'dart:io';
import 'package:avani_app/saved_pdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'service_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class PDFGenerator {
  static Future<void> savePDFPath(String pdfPath) async {
    await DatabaseHelper.instance.savePDFPath(pdfPath);
  }

  static Future<String> generatePDF(MergedData serviceFormData) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
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
                // Add more text or widgets as needed
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF to a file
    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/service_form.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    // Save the PDF path to the database table
    await savePDFPath(filePath);

    return filePath;
  }
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  // List<MergedData> savedServiceFormData = [];
  String searchQuery = '';
  // late DateTime selectedDateFilter;
  List<MergedData> savedServiceFormData = [];
  DateTime? selectedDateFilter; // Initialize to null

  List<String> savedPDFs = [];
  // void _printPDF(MergedData serviceFormData) async {
  //   // Generate the PDF file
  //   String pdfPath = await PDFGenerator.generatePDF(serviceFormData);

  //   // Print the PDF
  //   final File file = File(pdfPath);
  //   if (await file.exists()) {
  //     // Assuming you have a printer connected and configured
  //     await Process.run('lp', [pdfPath]);
  //     print('PDF printed successfully');
  //   } else {
  //     print('PDF file not found');
  //   }

  //   // Save the PDF path to the list in SavedPDFListScreen
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SavedPDFListScreen(),
  //     ),
  //   );
  // }
  void _printPDF(MergedData serviceFormData) async {
    // Generate the PDF file
    String pdfPath = await PDFGenerator.generatePDF(serviceFormData);

    // Save the PDF path to the list in SavedPDFListScreen
    setState(() {
      savedPDFs.add(pdfPath);
    });

    // Navigate to the SavedPDFListScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedPDFListScreen(),
      ),
    );
  }

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
              child: Text('Print PDF'),
              onPressed: () {
                _printPDF(serviceFormData);
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
        title: Text('Service List Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2030),
                );

                if (picked != null) {
                  setState(() {
                    selectedDateFilter = picked;
                  });
                }
              },
              child: Text('Filter by Date'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredServiceFormData().length,
              itemBuilder: (context, index) {
                MergedData serviceFormData = _filteredServiceFormData()[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      _showServiceDetailsDialog(serviceFormData, context);
                    },
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location : ${serviceFormData.location}'),
                        Text('Date : ${serviceFormData.createdDate}'),
                        Text(
                            'Before Temperature : ${serviceFormData.beforeRoomTemperature}'),
                        Text(
                            'After Temperature : ${serviceFormData.afterRoomTemperature}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          _deleteServiceFormData(serviceFormData.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationListScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'LocationList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ServiceList',
          ),
        ],
      ),
    );
  }
}
