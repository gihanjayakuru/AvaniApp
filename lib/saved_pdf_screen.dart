import 'dart:io';

import 'package:avani_app/location_list.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'database_helper.dart';
import 'my_form_screen.dart';
import 'service_list.dart'; // Import your database helper class

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

  // Future<void> _openPDF(String path) async {
  //   PDFDocument doc = await PDFDocument.fromAsset(path);
  //   setState(() {
  //     pdfDocument = doc;
  //   });
  // }
  Future<void> _openPDF(String path) async {
    print('Openening .......... this file path ::${path}');
    File file = File(path);
    PDFDocument doc = await PDFDocument.fromFile(file);
    setState(() {
      pdfDocument = doc;
    });
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
                    _openPDF(pdfPath);
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
}
