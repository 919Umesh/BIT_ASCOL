// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import '../../config/const.dart';
// import '../../services/sharePref/get_all_Pref.dart';
// import 'create_event.dart';
// import 'event_details.dart';
//
// class UpcomingEvent extends StatefulWidget {
//   const UpcomingEvent({super.key});
//
//   @override
//   State<UpcomingEvent> createState() => _UpcomingEventState();
// }
//
// class _UpcomingEventState extends State<UpcomingEvent> {
//   late Future<List<Map<String, dynamic>>> _eventsFuture;
//   late Future<bool> _isAdminFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _eventsFuture = _fetchEvents();
//     _isAdminFuture = GetAllPref.getIsAdmin();
//   }
//
//   Future<List<Map<String, dynamic>>> _fetchEvents() async {
//     try {
//       final databaseReference = FirebaseDatabase.instanceFor(
//         app: Firebase.app(),
//         databaseURL: "https://bitascol-a24f2-default-rtdb.asia-southeast1.firebasedatabase.app/",
//       ).ref().child('events');
//
//       final snapshot = await databaseReference.get();
//
//       if (snapshot.exists) {
//         final data = snapshot.value as Map<dynamic, dynamic>;
//
//         final events = (data).entries.map((entry) {
//           final event = entry.value as Map<dynamic, dynamic>;
//           final dateTimeStr = event['datetime'] as String? ?? DateTime.now().toIso8601String();
//           final dateTime = DateTime.parse(dateTimeStr);
//
//           return {
//             'id': entry.key,
//             'title': event['title'] as String? ?? 'No Title',
//             'description': event['description'] as String? ?? 'No Description',
//             'fileUrl': event['fileUrl'] as String? ?? '',
//             'datetime': dateTimeStr,
//             'formattedDateTime': DateFormat('yyyy-MM-dd – kk:mm').format(dateTime),
//             'isUpcoming': dateTime.isAfter(DateTime.now()),
//           };
//         }).toList();
//
//         events.sort((a, b) {
//           final dateA = DateTime.parse(a['datetime'] as String);
//           final dateB = DateTime.parse(b['datetime'] as String);
//           return dateB.compareTo(dateA);
//         });
//
//         return events;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       debugPrint('Error fetching events: ${e.toString()}');
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upcoming Events', style: TextStyle(color: Colors.white)),
//         backgroundColor: primaryColor, // Use primaryColor for AppBar
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Navigator.of(context).push(
//       //       MaterialPageRoute(
//       //         builder: (context) => const CreateEvent(),
//       //       ),
//       //     );
//       //   },
//       //   child: const Icon(Icons.add),
//       //   backgroundColor: primaryColor, // Match FAB color with AppBar
//       // ),
//       floatingActionButton: FutureBuilder<bool>(
//         future: _isAdminFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const SizedBox();
//           }
//
//           if (snapshot.hasError) {
//             return const SizedBox();
//           }
//
//           final isAdmin = snapshot.data ?? false;
//
//           return isAdmin
//               ? FloatingActionButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const CreateEvent(),
//                 ),
//               );
//             },
//             child: const Icon(Icons.add),
//           )
//               : const SizedBox();
//         },
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _eventsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: SizedBox(
//                 height: 100,
//                 width: 100,
//                 child: LoadingIndicator(
//                   indicatorType: Indicator.ballTrianglePathColored,
//                   colors: [Colors.blue, Colors.red, Colors.green],
//                   strokeWidth: 4,
//                 ),
//               ),
//             );
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No events available.'));
//           }
//
//           final events = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index];
//               final isUpcoming = event['isUpcoming'] as bool;
//               final dateColor = isUpcoming ? Colors.green : Colors.red; // Set color based on date
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 elevation: 4, // Add elevation to Card
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12), // Rounded corners
//                 ),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.all(8),
//                   // Add padding inside ListTile
//                   title: Text(
//                     'Date: ${event['formattedDateTime'] as String}',
//                     style: TextStyle(color: dateColor,fontSize: 20,fontWeight: FontWeight.bold), // Style date based on condition
//                   ),
//                   subtitle: Text(
//                     'Event: ${event['title'] as String}',
//                     style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor), // Style title
//                   ),
//
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => EventDetails(
//                           title: event['title'] as String,
//                           description: event['description'] as String,
//                           fileUrl: event['fileUrl'] as String,
//                           datetime: event['datetime'] as String,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//

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
            'formattedDateTime': DateFormat('MMM dd, yyyy').format(dateTime),
            'formattedTime': DateFormat('hh:mm a').format(dateTime),
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballTrianglePathColored,
                        colors: [Colors.blue, Colors.red, Colors.green],
                        strokeWidth: 4,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading Events...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No events available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          final events = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final isUpcoming = event['isUpcoming'] as bool;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUpcoming ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  event['formattedDateTime'] as String,
                                  style: TextStyle(
                                    color: isUpcoming ? Colors.green[700] : Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  event['formattedTime'] as String,
                                  style: TextStyle(
                                    color: isUpcoming ? Colors.green[700] : Colors.red[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  event['description'] as String,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isUpcoming ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        isUpcoming ? 'Upcoming' : 'Past Event',
                                        style: TextStyle(
                                          color: isUpcoming ? Colors.green[700] : Colors.red[700],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: _isAdminFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const SizedBox();
          }

          final isAdmin = snapshot.data ?? false;

          return isAdmin
              ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateEvent(),
                  ),
                );
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: const Icon(Icons.add, size: 28),
            ),
          )
              : const SizedBox();
        },
      ),
    );
  }
}