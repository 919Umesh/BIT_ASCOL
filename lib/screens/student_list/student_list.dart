// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import '../../config/const.dart';
//
// class StudentList extends StatelessWidget {
//   const StudentList({super.key});
//
//   Future<List<Map<String, dynamic>>> _fetchUsers() async {
//     try {
//       final firestore = FirebaseFirestore.instance;
//       final snapshot = await firestore.collection('usersData').get();
//       final userDocs = snapshot.docs;
//
//       return userDocs.map((doc) {
//         final data = doc.data();
//         return {
//           'name': data['name'] ?? 'No Name',
//         };
//       }).toList();
//     } catch (e) {
//       throw Exception('Failed to load users: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student List',style: TextStyle(color: Colors.white),),
//         backgroundColor: primaryColor, // Use primaryColor for AppBar
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _fetchUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: SizedBox(
//                 height: 100,
//                 width: 100,
//                 child: LoadingIndicator(
//                   //ballTrianglePathColored
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
//             return const Center(child: Text('No users available.'));
//           }
//
//           final users = snapshot.data!;
//
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 elevation: 4, // Add elevation to Card
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8), // Rounded corners
//                 ),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.only(left: 16), // Add padding inside ListTile
//                   title: Text(
//                     user['name'] ?? 'No Name',
//                     style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor), // Style title
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../config/const.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('usersData').get();
      final userDocs = snapshot.docs;

      return userDocs.map((doc) {
        final data = doc.data();
        return {
          'name': data['name'] ?? 'No Name',
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Student List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),

        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballTrianglePathColored,
                    colors: [Colors.blue, Colors.red, Colors.green],
                    strokeWidth: 4,
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red[100]!),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Students Available',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Students will appear here once added',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final users = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final String name = user['name'] ?? 'No Name';
              final String initials = name.isNotEmpty ? name[0].toUpperCase() : 'N';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: primaryColor.withOpacity(0.1),
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  trailing: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}