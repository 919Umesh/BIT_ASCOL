import 'dart:io';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({super.key});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  File? _selectedImage;
  String? _title;
  String? _description;
  final DateTime _selectedDateTime = DateTime.now();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _uploadAssignment() async {
    if (_selectedImage == null || _title == null || _description == null) {
      Fluttertoast.showToast(msg: 'Please complete all fields and select an image');
      return;
    }

    try {
      final fileName = _selectedImage!.path.split('/').last;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('assignments/$fileName');

      await storageReference.putFile(_selectedImage!);
      final downloadURL = await storageReference.getDownloadURL();

      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('assignments');

      await databaseReference.push().set({
        'imageUrl': downloadURL,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'datetime': _selectedDateTime.toIso8601String(),
      });

      Fluttertoast.showToast(msg: 'Assignment uploaded and details stored successfully');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading assignment: ${e.toString()}')),
      );
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Assignment'),
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
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text(_selectedImage == null
                    ? 'Pick Image from Gallery'
                    : 'Image Selected: ${_selectedImage!.path.split('/').last}'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text('Pick Image from Camera'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadAssignment,
                child: const Text('Upload Assignment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
