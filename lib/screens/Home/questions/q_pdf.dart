import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;
import '../../../config/const.dart';

class PdfListQuestionScreen extends StatelessWidget {
  final String semester;
  final String subject;
  final List<Map<String, dynamic>> pdfList;

  const PdfListQuestionScreen({
    super.key,
    required this.semester,
    required this.subject,
    required this.pdfList,
  });

  @override
  Widget build(BuildContext context) {
    final filteredPdfs = pdfList.where((pdf) => pdf['semester'] == semester && pdf['subject'] == subject).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(subject,style: const TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredPdfs.isNotEmpty
            ? ListView.builder(
          itemCount: filteredPdfs.length,
          itemBuilder: (context, index) {
            final pdf = filteredPdfs[index];
            final fileName = _extractFileName(pdf['url']); // Extract the actual file name
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  fileName, // Display the actual file name
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('Subject: ${pdf['subject']}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_red_eye_rounded, color: primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(pdfUrl: pdf['url']),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
            : const Center(child: Text('No PDFs available')),
      ),
    );
  }

  // Function to extract the file name from URL
  String _extractFileName(String url) {
    final uri = Uri.parse(url);
    final filePath = uri.path;
    final decodedPath = Uri.decodeComponent(filePath); // Decode URL components
    return path.basename(decodedPath); // Get the file name from the decoded path
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
