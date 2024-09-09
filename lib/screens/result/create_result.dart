import 'dart:io';
import 'package:bit_ascol/utils/customLog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateResult extends StatefulWidget {
  const CreateResult({super.key});

  @override
  State<CreateResult> createState() => _CreateResultState();
}

class _CreateResultState extends State<CreateResult> {
  File? _selectedImage;
  String? _subject;
  final DateTime _selectedDateTime = DateTime.now();

  final _subjectController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
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

  Future<void> _uploadResult() async {
    if (_selectedImage == null || _subject == null) {
      Fluttertoast.showToast(msg: 'Please complete all fields and select an image');
      return;
    }

    try {
      final fileName = _selectedImage!.path.split('/').last;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('results/$fileName');

      await storageReference.putFile(_selectedImage!);
      final downloadURL = await storageReference.getDownloadURL();

      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('results');

      await databaseReference.push().set({
        'imageUrl': downloadURL,
        'subject': _subjectController.text,
        'datetime': _selectedDateTime.toIso8601String(),
      });

      Fluttertoast.showToast(msg: 'Result uploaded and details stored successfully');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading result: ${e.toString()}')),
      );
      CustomLog.successLog(value: e.toString());
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                onChanged: (value) {
                  _subject = value;
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
                onPressed: _uploadResult,
                child: const Text('Upload Result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
