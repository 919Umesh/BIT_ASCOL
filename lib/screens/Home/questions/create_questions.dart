import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateQuestions extends StatefulWidget {
  const CreateQuestions({super.key});

  @override
  State<CreateQuestions> createState() => _CreateQuestionsState();
}

class _CreateQuestionsState extends State<CreateQuestions> {
  File? _selectedFile;
  String? _semester;
  String? _subject;

  final List<String> _semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8',
  ];

  final Map<String, List<String>> _subjects = {
    'Semester 1': ['Basic Mathematics', ' C Programming', ' Digital Logic','Introduction to Information Technology',' Sociology'],
    'Semester 2': ['Discrete Structure', 'Microprocessor Computer Architecture', ' Object Oriented Programming',' Basic Statistics',' Economics'],
    'Semester 3': ['Data Structure and Algorithms', ' Database Management System', ' Numerical Methods',' Operating System',' Principles of Management'],
    'Semester 4': [' Web Technology I', ' Artificial Intelligence', ' System Analysis Design',' Network Data Communications',' Operations Research'],
    'Semester 5': ['Web Technology II', ' Software Engineering', ' Information Security',' Computer Graphics',' Technical Writing'],
    'Semester 6': ['Net-Centric Computing', ' Database Administration', ' Management Information System',' Research Methodology',' Geographical Information System'],
    'Semester 7': ['Advanced Java Programming', ' Software Project Management', 'E-Commerce',' Project Work',' Mobile Application Development'],
    'Semester 8': ['Network System Administration', ' E-Governance', 'Internship','Data Warehousing And Data Mining',' Network Security'],
  };

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadPdf() async {
    if (_selectedFile == null) return;

    try {
      final fileName = _selectedFile!.path.split('/').last;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('questions/$fileName');

      await storageReference.putFile(_selectedFile!);
      final downloadURL = await storageReference.getDownloadURL();

      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('questions');

      await databaseReference.push().set({
        'url': downloadURL,
        'semester': _semester,
        'subject': _subject,
      });

      setState(() {
      });
      Fluttertoast.showToast(msg: 'PDF uploaded and details stored successfully');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading PDF: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Semester'),
              value: _semester,
              onChanged: (newValue) {
                setState(() {
                  _semester = newValue;
                  _subject = null; // Reset the subject dropdown
                });
              },
              items: _semesters.map((semester) {
                return DropdownMenuItem(
                  value: semester,
                  child: Text(semester),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (_semester != null)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Subject'),
                value: _subject,
                onChanged: (newValue) {
                  setState(() {
                    _subject = newValue;
                  });
                },
                items: _subjects[_semester]!.map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
              ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _pickFile,
              child: Text(_selectedFile == null
                  ? 'Pick PDF File'
                  : 'File Selected: ${_selectedFile!.path.split('/').last}'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadPdf,
              child: const Text('Upload PDF'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

