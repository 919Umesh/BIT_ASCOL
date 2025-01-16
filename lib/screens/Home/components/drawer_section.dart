import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/assetList.dart';
import '../../../config/const.dart';
import '../../../retry.dart';
import '../../../utils/customLog.dart';
import '../../login.dart';
import '../about/aboutBit.dart';
import '../about/about_us.dart';
import '../about/ascol.dart';

class DrawerSection extends StatefulWidget {
  final String userName;
  final String profilePictureUm;
  final BuildContext context;

  const DrawerSection({
    super.key,
    required this.userName,
    required this.profilePictureUm,
    required this.context,
  });

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    fetchDataWithRetry();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Fluttertoast.showToast(
          msg: "User is not authenticated.",
          backgroundColor: Colors.red,
        );
        return;
      }

      if (_profileImage == null) {
        Fluttertoast.showToast(
          msg: "Image file is missing.",
          backgroundColor: Colors.red,
        );
        return;
      }

      try {
        final storageRef = FirebaseStorage.instance.ref().child('profilePictureUrl/${user.uid}.jpg');
        final uploadTask = storageRef.putFile(_profileImage!);

        final taskSnapshot = await uploadTask;
        final imageUrl = await taskSnapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('usersData').doc(user.uid).update({'profilePictureUrl': imageUrl,
        });

        setState(() {
        });

        Fluttertoast.showToast(
          msg: "Profile image updated",
          backgroundColor: Colors.green,
        );
      } catch (error) {
        CustomLog.successLog(value: "The error is:$error");
      }
    } else {
      Fluttertoast.showToast(
        msg: "No image selected.",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        width: screenWidth / 1.5,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            titleSection(context),
            Expanded(
              child: ListView(
                children: [
                  DrawerIconName(
                    name: "Dashboard",
                    iconName: Icons.dashboard,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  divider(),
                  DrawerIconName(
                    name: "ASCOL",
                    iconName: Icons.info,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutAscol()),
                      );
                    },
                  ),
                  divider(),
                  DrawerIconName(
                    name: "About BIT",
                    iconName: Icons.info_outline,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutBIT()),
                      );
                    },
                  ),
                  divider(),
                  DrawerIconName(
                    name: "About US",
                    iconName: Icons.info_outline,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUs()),
                      );
                    },
                  ),
                  divider(),
                  DrawerIconName(
                    name: "LogOut",
                    iconName: Icons.logout,
                    onTap: () async {
                      await logOut(context);
                    },
                  ),
                  divider(),
                  DrawerIconName(
                    name: "Delete Account",
                    iconName: Icons.delete_forever,
                    onTap: () async {
                      await _deleteAccount();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('usersData').doc(user.uid).delete();
        await user.delete();
        Fluttertoast.showToast(
          msg: "Account deleted successfully",
          backgroundColor: Colors.green,
        );
        Navigator.popUntil(widget.context, (route) => route.isFirst);
        Navigator.pushReplacement(
          widget.context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: ${error.toString()}",
        backgroundColor: Colors.red,
      );
    }
  }

  Widget titleSection(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: widget.profilePictureUm.isNotEmpty
                  ? NetworkImage(widget.profilePictureUm)
                  : AssetImage(AssetsList.appIcon) as ImageProvider,
              backgroundColor: Colors.transparent,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Amrit Science Campus(ASCOL)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "BIT | ASCOL",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Username: ${widget.userName}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget divider() {
    return Container(height: 1.0, color: Colors.grey.shade300);
  }
}

class DrawerIconName extends StatelessWidget {
  final String name;
  final IconData iconName;
  final VoidCallback onTap;

  const DrawerIconName({
    super.key,
    required this.iconName,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                iconName,
                size: 25.0,
                color: primaryColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
