

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:bit_ascol/screens/noteScreen/subject_List.dart';
import '../../components/check_connectivity.dart';
import '../../config/const.dart';
import '../../services/sharePref/get_all_Pref.dart';
import 'note_screen.dart';

class NotesScreen extends StatefulWidget {

  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> _pdfList = [];
  List<String> _semesters = [];
  bool _isLoading = true;
  late Future<bool> _isAdminFuture;

  @override
  void initState() {
    super.initState();
    _fetchPdfList();
    _isAdminFuture = GetAllPref.getIsAdmin();
  }

  Future<void> _fetchPdfList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool isConnected = await CheckNetwork.check();
      if (!isConnected) {
        Fluttertoast.showToast(
          msg: 'No internet connection. Please try again later.',
          backgroundColor: Colors.red,
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
      Fluttertoast.showToast(
        msg: 'Connection Found',
        backgroundColor: Colors.green,
      );
      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('pdfs');

      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        debugPrint('Data fetched: $data');
        if (data.isNotEmpty) {
          final pdfList = data.values.map((entry) {
            final pdfEntry = entry as Map<dynamic, dynamic>;
            return {
              'url': pdfEntry['url'] as String,
              'semester': pdfEntry['semester'] as String,
              'subject': pdfEntry['subject'] as String,
            };
          }).toList();

          setState(() {
            _pdfList = pdfList.cast<Map<String, dynamic>>();
            _semesters = _getSemesters(); // Extract unique semesters
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No PDF details found')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data found in the database')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching PDF details: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  List<String> _getSemesters() {
    return _pdfList.map((pdf) => pdf['semester'] as String).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Semester',style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballTrianglePathColored,
              colors: [Colors.blue, Colors.red, Colors.green],
              strokeWidth: 4,
            ),
          ),
        )
            : _semesters.isNotEmpty
            ? ListView.builder(
          itemCount: _semesters.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Semester: ${_semesters[index]}',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubjectListScreen(
                        semester: _semesters[index],
                        pdfList: _pdfList,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
            : const Center(child: Text('No Semesters available')),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNotes()));
      //   },
      //   backgroundColor: primaryColor,
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: FutureBuilder<bool>(
        future: _isAdminFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(); // Placeholder while loading
          }

          if (snapshot.hasError) {
            return const SizedBox(); // Handle error if needed
          }

          final isAdmin = snapshot.data ?? false;

          return isAdmin
              ? FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateNotes(),
                ),
              );
            },
            child: const Icon(Icons.add),
          )
              : const SizedBox(); // Hide FAB if not admin
        },
      ),
    );
  }
}
