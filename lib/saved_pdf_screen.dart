// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class SavedPDFScreen extends StatelessWidget {
//   final String pdfPath;

//   const SavedPDFScreen({required this.pdfPath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved PDF'),
//       ),
//       body: PDFView(
//         filePath: pdfPath,
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class SavedPDFScreen extends StatefulWidget {
  final String pdfPath;

  SavedPDFScreen({required this.pdfPath});

  @override
  _SavedPDFScreenState createState() => _SavedPDFScreenState();
}

class _SavedPDFScreenState extends State<SavedPDFScreen> {
  late PDFViewController _pdfViewController;
  int _currentPage = 0;
  int _totalPages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved PDF'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PDFView(
              filePath: widget.pdfPath,
              onViewCreated: (PDFViewController pdfViewController) {
                _pdfViewController = pdfViewController;
                _getTotalPages();
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page ?? 0;
                  _totalPages = total ?? 0;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: Icon(Icons.arrow_back),
                ),
                Text('Page ${_currentPage + 1} of $_totalPages'),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _getTotalPages() async {
  //   int? totalPages = await _pdfViewController.getPageCount();
  //   setState(() {
  //     _totalPages = totalPages!;
  //   });
  // }
  void _getTotalPages() async {
    int totalPages = await _pdfViewController.getPageCount() ?? 0;
    setState(() {
      _totalPages = totalPages;
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pdfViewController.setPage(_currentPage - 1);
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pdfViewController.setPage(_currentPage + 1);
    }
  }
}
