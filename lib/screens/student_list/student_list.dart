


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
      appBar: AppBar(
        title: const Text('Student List',style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: LoadingIndicator(
                  //ballTrianglePathColored
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
            return const Center(child: Text('No users available.'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // Add elevation to Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16), // Add padding inside ListTile
                  title: Text(
                    user['name'] ?? 'No Name',
                    style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor), // Style title
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
