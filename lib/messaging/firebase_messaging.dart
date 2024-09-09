// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
// final AndroidNotificationChannel? channel = channel;
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint('Handling a background message: ${message.messageId}');
// }
//
// void setupFirebaseMessaging() {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     debugPrint('Message received in foreground: ${message.messageId}');
//
//     if (flutterLocalNotificationsPlugin != null) {
//       final notification = message.notification;
//       if (notification != null) {
//         flutterLocalNotificationsPlugin!.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel!.id,
//               channel!.name,
//               channelDescription: channel!.description,
//               importance: Importance.high,
//               priority: Priority.high,
//             ),
//           ),
//         );
//       }
//     }
//   });
//
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     debugPrint('Notification tapped: ${message.messageId}');
//   });
// }
