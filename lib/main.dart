import 'package:bit_ascol/messaging/firebase_messaging.dart';
import 'package:bit_ascol/screens/artificail_Intelligence/locator.dart';
import 'package:bit_ascol/services/router/router_helper.dart';
import 'package:bit_ascol/splashScreen.dart';
import 'package:bit_ascol/utils/customLog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  setUpLocator();
  //Gemini.init(apiKey: 'AIzaSyDr-kAw-M0eNXfCDMhFO_pNdRhAQibXids',);
  Gemini.init(apiKey: 'AIzaSyB38ZlrueV7Cc0LdD51VIteLHV3cWJT9Sg',);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  CustomLog.errorLog(value: fcmToken);
  final pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
  //  User? currentUser = FirebaseAuth.instance.currentUser;
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:   SplashScreen(),
      //home: (FirebaseAuth.instance.currentUser != null) ?  HomeScreen(userId: userId) : const LoginScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}