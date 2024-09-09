// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// //
// // class PushNotificationService {
// //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// //
// //   Future<void> init() async {
// //     // Request permission for notifications
// //     NotificationSettings settings = await _fcm.requestPermission(
// //       alert: true,
// //       badge: true,
// //       sound: true,
// //     );
// //
// //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// //       print('User granted permission');
// //     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
// //       print('User granted provisional permission');
// //     } else {
// //       print('User declined or has not accepted permission');
// //     }
// //
// //     // Get the token
// //     String? token = await _fcm.getToken();
// //     print("Firebase Messaging Token: $token");
// //
// //     // Handle foreground messages
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       RemoteNotification? notification = message.notification;
// //       AndroidNotification? android = message.notification?.android;
// //
// //       if (notification != null && android != null) {
// //         // Display a notification, or handle the message in another way.
// //         print("Message received: ${notification.title} - ${notification.body}");
// //       }
// //     });
// //
// //     // Handle background messages
// //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //   }
// //
// //   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //     await Firebase.initializeApp();
// //     print("Handling a background message: ${message.messageId}");
// //   }
// // }
//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future<void> init() async {
//     // Request permission for notifications
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//
//     // Get the token
//     String? token = await _fcm.getToken();
//     print("Firebase Messaging Token: $token");
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         // Display a notification, or handle the message in another way.
//         print("Message received: ${notification.title} - ${notification.body}");
//       }
//     });
//
//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print("Handling a background message: ${message.messageId}");
//   }
// }
