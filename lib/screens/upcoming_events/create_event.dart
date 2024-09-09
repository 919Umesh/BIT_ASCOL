import 'dart:io';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart'; // For date and time formatting

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  File? _selectedFile;
  String? _title;
  String? _description;
  DateTime _selectedDateTime = DateTime.now();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _selectedFile = File(file.path);
      });
    }
  }

  Future<void> _uploadEvent() async {
    if (_selectedFile == null || _title == null || _description == null) {
      Fluttertoast.showToast(msg: 'Please complete all fields and select a file');
      return;
    }

    try {
      final fileName = _selectedFile!.path.split('/').last;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('events/$fileName');

      await storageReference.putFile(_selectedFile!);
      final downloadURL = await storageReference.getDownloadURL();

      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('events');

      await databaseReference.push().set({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'datetime': _selectedDateTime.toIso8601String(),
        'fileUrl': downloadURL,
      });

      Fluttertoast.showToast(msg: 'Event created and details stored successfully');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating event: ${e.toString()}')),
      );
      Fluttertoast.showToast(msg: '$e');
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDateTime) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  _description = value;
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _pickFile(ImageSource.gallery),
                child: Text(_selectedFile == null
                    ? 'Pick File from Gallery'
                    : 'File Selected: ${_selectedFile!.path.split('/').last}'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _pickFile(ImageSource.camera),
                child: const Text('Pick File from Camera'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date & Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDateTime)}',
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    child: const Text('Select Date & Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadEvent,
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
