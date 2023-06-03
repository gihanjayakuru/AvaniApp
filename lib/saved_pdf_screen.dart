import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          moveFileToExternalStorage(pdfPath);
                          print('pdfPatesfdsf___----====:::::h${pdfPath}');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deletePDF(pdfPath);
                        },
                      ),
                    ],
                  ),
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
            label: 'Add Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: 'Select Locationsn',
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

  void _deletePDF(String path) async {
    try {
      File file = File(path);
      bool exists = await file.exists();
      if (exists) {
        await DatabaseHelper.instance.deletePDF(path);
        _loadSavedPDFs(); // Refresh the list before deleting the file

        await file.delete();
      } else {
        print('PDF file does not exist at path: $path');
      }
    } catch (e) {
      print('Error deleting PDF: $e');
    }
  }

  // void _deletePDF(String path) async {
  //   try {
  //     File file = File(path);
  //     bool exists = await file.exists();
  //     if (exists) {
  //       await file.delete();
  //       await DatabaseHelper.instance.deletePDF(path);
  //       _loadSavedPDFs();
  //     } else {
  //       print('PDF file does not exist at path: $path');
  //     }
  //   } catch (e) {
  //     print('Error deleting PDF: $e');
  //   }
  // }
  Future<void> openPDFDirectorys(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      print('Error opening PDF file: $e');
    }
  }

  // Future<void> moveFileToExternalStorage(String filePath) async {
  //   try {
  //     // Get the external storage directory
  //     final directory = await getExternalStorageDirectory();
  //     if (directory != null) {
  //       // Create the destination path in the external storage directory
  //       final destinationPath = '${directory.path}/report.pdf';

  //       // Move the file to the destination path
  //       final file = File(filePath);
  //       await file.rename(destinationPath);

  //       print('File moved to: $destinationPath');
  //     }
  //   } catch (e) {
  //     print('Error moving file: $e');
  //   }
  // }

  // import 'package:file_picker/file_picker.dart';
  // Future<void> openPDFDirectory(String filePath) async {
  //   try {
  //     final result = await FilePicker.platform
  //         .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //     if (result != null) {
  //       final filePath = result.files.single.path;
  //       if (filePath != null) {
  //         // Use the filePath to open the PDF file
  //         // For example, you can use the OpenFile.open method:
  //         await OpenFile.open(filePath);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error opening PDF file: $e');
  //   }
  // }

  // void _launchFileExplorer(String filePath) async {
  //   print('calling Launch file explorer: $filePath');
  //   try {
  //     final directory = filePath.substring(0, filePath.lastIndexOf('/'));
  //     final parentDir = await FilePicker.platform.getDirectoryPath(
  //       initialDirectory: directory,
  //     );
  //     if (parentDir != null) {
  //       await OpenFile.open(parentDir);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: 'File explorer app is required to open the file location.',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //       );
  //     }
  //   } catch (e) {
  //     print('Error opening file explorer: $e');
  //     Fluttertoast.showToast(
  //       msg: 'File explorer app is required to open the file location.',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }
  // }
  Future<void> moveFileToExternalStorage(String filePath) async {
    try {
      final file = File(filePath);

      // Prompt the user to choose a new save location
      Directory? newSaveLocation = await getExternalStorageDirectory();

      if (newSaveLocation != null) {
        // Generate a unique file name
        String newFileName =
            'report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        // Construct the new save path
        String newSavePath = path.join(newSaveLocation.path, newFileName);

        // Read the contents of the original file
        List<int> fileBytes = await file.readAsBytes();

        // Write the contents to the new save path
        await File(newSavePath).writeAsBytes(fileBytes);

        await OpenFile.open(newSavePath);
        // openPDFDirectory(newSavePath);
        // Delete the original file
        // await file.delete();

        print('File moved to: $newSavePath');
      } else {
        print('New save location not found.');
      }
    } catch (e) {
      print('Error moving file: $e');
    }
  }

  Future<void> moveFileToExternalStosrage(String filePath) async {
    try {
      final file = File(filePath);

      // Extract the suggested file name from the existing file path
      String suggestedFileName = filePath.split('/').last;

      // Prompt the user to choose a new save location
      String? newSavePath = await FilePicker.platform.saveFile(
        fileName: suggestedFileName,
      );

      if (newSavePath != null) {
        // Move the file to the new save location
        final newFile = await file.copy(newSavePath);

        print('File moved to: ${newFile.path}');
      } else {
        print('New save location not selected.');
      }
    } catch (e) {
      print('Error moving file: $e');
    }
  }

  Future<void> moveFileToExternalStoragse(String filePath) async {
    try {
      final file = File(filePath);

      // Get the external storage directory
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        // Create the destination path in the external storage directory
        final destinationPath = '${directory.path}/report.pdf';

        // Move the file to the destination path
        await file.rename(destinationPath);

        print('File moved to: $destinationPath');
      }
    } catch (e) {
      print('Error moving file: $e');
    }
  }

  Future<void> openPDFDirectoryss(String filePath) async {
    print('File Patth to OPen Directory >>>>>>>>>--------${filePath}');
    try {
      final directory = File(filePath).parent;
      await OpenFile.open(directory.path);
    } catch (e) {
      print(
          'Error opening PDF directory FFFFFFFFFFFFFFFFFFFFFFFFFFFFF>>>>>>>>: $e');
    }
  }

  // bool isFileExists(String pat) {
  //   final file = File(pat);

  //   print("File exissssss=====${file.existsSync()}");
  //   return file.existsSync();
  // }

  // void _launchFileExplorer(String filePath) async {
  //   if (await canLaunch(filePath)) {
  //     await launch(filePath);
  //   } else {
  //     print('Error opening PDF file');
  //   }
  // }

  // Future<void> openPDFDirectory(String filePath) async {
  //   try {
  //     await OpenFile.open(filePath);
  //   } catch (e) {
  //     print('Error opening PDF file: $e');
  //   }
  // }

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
