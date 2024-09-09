import 'package:bit_ascol/services/sharePref/get_all_Pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'result_details.dart';
import 'create_result.dart';

class ResultList extends StatefulWidget {
  const ResultList({super.key});

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  late Future<List<Map<String, dynamic>>> _resultsFuture;
  late Future<bool> _isAdminFuture;

  @override
  void initState() {
    super.initState();
    _resultsFuture = _fetchResults();
    _isAdminFuture = GetAllPref.getIsAdmin();
  }

  Future<List<Map<String, dynamic>>> _fetchResults() async {
    try {
      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('results').limitToLast(20);

      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        debugPrint('Data fetched: $data');

        final results = data.entries.map((entry) {
          final result = entry.value as Map<dynamic, dynamic>;
          return {
            'key': entry.key,
            'subject': result['subject'] as String? ?? 'No Subject',
            'datetime': result['datetime'] as String? ?? DateTime.now().toIso8601String(),
            'imageUrl': result['imageUrl'] as String? ?? '',
          };
        }).toList();

        results.sort((a, b) {
          DateTime dateA = DateTime.parse(a['datetime']);
          DateTime dateB = DateTime.parse(b['datetime']);
          return dateB.compareTo(dateA); // Descending order
        });

        return results;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching results: ${e.toString()}');
      return [];
    }
  }

  String _formatDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _resultsFuture,
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

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results available.'));
          }

          List<Map<String, dynamic>> results = snapshot.data!;

          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final result = results[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(result['subject']!),
                  subtitle: Text('Date: ${_formatDateTime(result['datetime'])}'),
                  // subtitle: Text('Date: ${result['datetime']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultDetailScreen(
                          result: result,
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
                        builder: (context) => const CreateResult(),
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
