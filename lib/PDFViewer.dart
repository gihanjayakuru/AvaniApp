import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatefulWidget {
  final String filePath;

  PDFViewerScreen({required this.filePath});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late PDFViewController _pdfViewController;
  int? _currentPage;
  int? _totalPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PDFView(
              filePath: widget.filePath,
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                });
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _pdfViewController = pdfViewController;
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  _currentPage = page;
                  _totalPages = total;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    _pdfViewController.setPage(_currentPage! - 1);
                  },
                ),
                Text(
                  _currentPage != null && _totalPages != null
                      ? 'Page ${_currentPage! + 1} of $_totalPages'
                      : 'Page',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    _pdfViewController.setPage(_currentPage! + 1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
