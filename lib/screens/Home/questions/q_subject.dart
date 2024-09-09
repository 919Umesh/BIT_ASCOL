import 'package:bit_ascol/screens/noteScreen/pdf_List.dart';
import 'package:flutter/material.dart';
import '../../../config/const.dart';

class QuestionSubListScreen extends StatelessWidget {
  final String semester;
  final List<Map<String, dynamic>> pdfList;

  const QuestionSubListScreen({
    super.key,
    required this.semester,
    required this.pdfList,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = pdfList.where((pdf) => pdf['semester'] == semester).map((pdf) => pdf['subject'] as String).toSet().toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(semester,style: const TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: subjects.isNotEmpty
            ? ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  subjects[index],
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfListScreen(
                        semester: semester,
                        subject: subjects[index],
                        pdfList: pdfList,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
            : const Center(child: Text('No Subjects available')),
      ),
    );
  }
}
