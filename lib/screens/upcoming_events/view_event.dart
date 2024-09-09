import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../config/const.dart';
import '../../services/sharePref/get_all_Pref.dart';
import 'create_event.dart';
import 'event_details.dart';

class UpcomingEvent extends StatefulWidget {
  const UpcomingEvent({super.key});

  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  late Future<List<Map<String, dynamic>>> _eventsFuture;
  late Future<bool> _isAdminFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = _fetchEvents();
    _isAdminFuture = GetAllPref.getIsAdmin();
  }

  Future<List<Map<String, dynamic>>> _fetchEvents() async {
    try {
      final databaseReference = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
      ).ref().child('events');

      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        final events = (data).entries.map((entry) {
          final event = entry.value as Map<dynamic, dynamic>;
          final dateTimeStr = event['datetime'] as String? ?? DateTime.now().toIso8601String();
          final dateTime = DateTime.parse(dateTimeStr);

          return {
            'id': entry.key,
            'title': event['title'] as String? ?? 'No Title',
            'description': event['description'] as String? ?? 'No Description',
            'fileUrl': event['fileUrl'] as String? ?? '',
            'datetime': dateTimeStr,
            'formattedDateTime': DateFormat('yyyy-MM-dd – kk:mm').format(dateTime),
            'isUpcoming': dateTime.isAfter(DateTime.now()),
          };
        }).toList();

        events.sort((a, b) {
          final dateA = DateTime.parse(a['datetime'] as String);
          final dateB = DateTime.parse(b['datetime'] as String);
          return dateB.compareTo(dateA);
        });

        return events;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching events: ${e.toString()}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => const CreateEvent(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: primaryColor, // Match FAB color with AppBar
      // ),
      floatingActionButton: FutureBuilder<bool>(
        future: _isAdminFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          if (snapshot.hasError) {
            return const SizedBox();
          }

          final isAdmin = snapshot.data ?? false;

          return isAdmin
              ? FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateEvent(),
                ),
              );
            },
            child: const Icon(Icons.add),
          )
              : const SizedBox();
        },
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _eventsFuture,
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
            return const Center(child: Text('No events available.'));
          }

          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final isUpcoming = event['isUpcoming'] as bool;
              final dateColor = isUpcoming ? Colors.green : Colors.red; // Set color based on date

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // Add elevation to Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  // Add padding inside ListTile
                  title: Text(
                    'Date: ${event['formattedDateTime'] as String}',
                    style: TextStyle(color: dateColor,fontSize: 20,fontWeight: FontWeight.bold), // Style date based on condition
                  ),
                  subtitle: Text(
                    'Event: ${event['title'] as String}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor), // Style title
                  ),

                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventDetails(
                          title: event['title'] as String,
                          description: event['description'] as String,
                          fileUrl: event['fileUrl'] as String,
                          datetime: event['datetime'] as String,
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
    );
  }
}

