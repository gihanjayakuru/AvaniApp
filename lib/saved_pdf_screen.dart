import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'PDFViewer.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'my_form_screen.dart';
import 'service_list.dart';

class SavedPDFListScreen extends StatefulWidget {
  @override
  _SavedPDFListScreenState createState() => _SavedPDFListScreenState();
}

class _SavedPDFListScreenState extends State<SavedPDFListScreen> {
  List<String> savedPDFs = [];
  PDFDocument? pdfDocument;

  @override
  void initState() {
    super.initState();
    _loadSavedPDFs();
  }

  void _loadSavedPDFs() async {
    List<String> pdfPaths = await DatabaseHelper.instance.getSavedPDFs();

    setState(() {
      savedPDFs = pdfPaths;
    });
  }

  Future<void> _openPDF(String path) async {
    print('onpress in saved pdf list:pressed path:-${path}');
    try {
      File file = File(path);
      bool exists = await file.exists();
      if (exists) {
        final pdf = await PDFDocument.fromFile(file);
        setState(() {
          pdfDocument = pdf;
        });
      } else {
        print('PDF file does not exist at path: $path');
      }
    } catch (e) {
      print('Error opening PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved PDFs'),
      ),
      body: pdfDocument != null
          ? PDFViewer(document: pdfDocument!)
          : ListView.builder(
              itemCount: savedPDFs.length,
              itemBuilder: (context, index) {
                String pdfPath = savedPDFs[index];
                return ListTile(
                  title: Text(pdfPath),
                  onTap: () {
                    _openPDFtonewscreen(pdfPath);
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Set the index of the current page
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServiceListScreen()),
            );
          } else if (index == 3) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SavedPDFListScreen()),
            // );
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

  void _openPDFtonewscreen(String path) {
    print(
        'sending this path value in the_openPDFtonewscreen:::::------ ${path}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(filePath: path),
      ),
    );
  }
}
