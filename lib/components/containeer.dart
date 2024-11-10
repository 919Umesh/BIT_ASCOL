

import 'package:flutter/material.dart';
import '../retry.dart';
import 'greetings.dart';

class TopContainer extends StatefulWidget {
  final String userName;
  final String profilePictureUrl;

  const TopContainer({
    super.key,
    required this.userName,
    required this.profilePictureUrl,
  });

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    fetchDataWithRetry();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: screenHeight / 5,
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const GreetingText(),
              const SizedBox(height: 5),
              Text(
                widget.userName.isNotEmpty?widget.userName:'BIT | ASCOL',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ClipOval(
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
               widget.profilePictureUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.account_circle,
                      size: 60, color: Colors.white);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
