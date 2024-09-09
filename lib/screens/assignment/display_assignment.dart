import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../config/const.dart';
import '../../services/sharePref/get_all_Pref.dart';
import 'assignment_details.dart';
import 'create_assignment.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({super.key});

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  late Future<List<Map<String, dynamic>>> _assignmentsFuture;
  late Future<bool> _isAdminFuture;

  @override
  void initState() {
    super.initState();
    _assignmentsFuture = _fetchAssignments();
    _isAdminFuture = GetAllPref.getIsAdmin();
  }

  Future<List<Map<String, dynamic>>> _fetchAssignments() async {
    try {
      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('assignments');

      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        debugPrint('Data fetched: $data');

        final assignments = data.entries.map((entry) {
          final assignment = entry.value as Map<dynamic, dynamic>;
          return {
            'key': entry.key,
            'title': assignment['title'] as String? ?? 'No Title',
            'description':
                assignment['description'] as String? ?? 'No Description',
            'datetime': assignment['datetime'] as String? ??
                DateTime.now().toIso8601String(),
            'imageUrl': assignment['imageUrl'] as String? ?? '',
          };
        }).toList();

        // Sort assignments by date
        assignments.sort((a, b) {
          final dateA = DateTime.parse(a['datetime']);
          final dateB = DateTime.parse(b['datetime']);
          return dateB.compareTo(dateA); // Descending order
        });

        return assignments;
      } else {
        _showSnackbar('No assignments available.');
        return [];
      }
    } catch (e) {
      _showSnackbar('Error fetching assignments: ${e.toString()}');
      return [];
    }
  }
  String _formatDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
  }


  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor, // Use primary color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _assignmentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballTrianglePathColored,
                    colors: [Colors.blue, Colors.red, Colors.green],
                    strokeWidth: 4,
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final assignments = snapshot.data ?? [];

            if (assignments.isEmpty) {
              return const Center(child: Text('No assignments available.'));
            }

            return ListView.builder(
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      assignment['title']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    // subtitle: Text(
                    //   'Date: ${assignment['datetime']!}',
                    //   style: TextStyle(color: Colors.black87),
                    // ),
                    subtitle: Text('Date: ${_formatDateTime(assignment['datetime'])}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssignmentDetailScreen(
                            assignment: assignment,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => const CreateAssignment(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: primaryColor, // Use primary color for the FAB
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
                  builder: (context) => const CreateAssignment(),
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
