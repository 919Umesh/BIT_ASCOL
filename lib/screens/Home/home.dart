import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/containeer.dart';
import '../../components/gridListView.dart';
import '../../components/title_text.dart';
import '../../retry.dart';
import '../../services/sharePref/set_all_Pref.dart';
import '../login.dart';
import 'components/drawer_section.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String profilePictureUrl = "";
  List<String> pdfUrls = [];
  bool isLoading = true;
  bool isAdmin = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      setState(() {
        isLoading = true;
      });


      await fetchUserName();

      await fetchDataWithRetry();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log("Error initializing data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('usersData')
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        if (mounted) {
          setState(() {
            userName = userDoc.get('name') ?? '';
            profilePictureUrl = userDoc.get('profilePictureUrl') ?? '';
            isAdmin = userDoc.get('isAdmin') ?? false;
          });
        }

        await SetAllPref.setIsAdmin(value: isAdmin);

        if (isAdmin) {
          Fluttertoast.showToast(
              msg: "Admin access granted",
              backgroundColor: Colors.green
          );
        }
      } else {
        log("User does not exist.");
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }


  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {  // Check if widget is still mounted
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
      Fluttertoast.showToast(
          msg: "Successfully logged out",
          backgroundColor: Colors.green
      );
    } catch (e) {
      log("Error during logout: $e");
      Fluttertoast.showToast(
          msg: "Error during logout",
          backgroundColor: Colors.red
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerSection(
        profilePictureUm: profilePictureUrl,
        userName: userName,
        context: context,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                TopContainer(
                  userName: userName,
                  profilePictureUrl: profilePictureUrl,
                ),
                const TitleText(),
                const GridListView(),
              ],
            ),
          ),
          Positioned(
            top: 110,
            left: 12,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
      ),
    );
  }
}
