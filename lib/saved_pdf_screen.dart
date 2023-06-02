import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import your database helper class

class SavedPDFListScreen extends StatefulWidget {
  @override
  _SavedPDFListScreenState createState() => _SavedPDFListScreenState();
}

class _SavedPDFListScreenState extends State<SavedPDFListScreen> {
  List<String> savedPDFs = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved PDFs'),
      ),
      body: ListView.builder(
        itemCount: savedPDFs.length,
        itemBuilder: (context, index) {
          String pdfPath = savedPDFs[index];
          return ListTile(
            title: Text(pdfPath),
            onTap: () {
              // TODO: Handle onTap action for the PDF item
            },
          );
        },
      ),
    );
  }
}
