import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  // Firebase Messaging instance
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize notification channels and settings
  Future<void> initialize() async {
    // Request permission for iOS devices
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Configure local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );

    // Get FCM token
    String? token = await _fcm.getToken();
    print('FCM Token: $token');

    // Save this token to your backend server for later use

    // Listen to token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      // Update token on your backend server
      print('New FCM Token: $newToken');
    });

    // Handle received messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Handle when user taps on notification when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleBackgroundMessage(message);
    });

    // Handle when app is launched from terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleTerminatedMessage(initialMessage);
    }
  }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }
  }

  // Handle background messages
  void _handleBackgroundMessage(RemoteMessage message) {
    print('Handling background message: ${message.messageId}');
    // Navigate to specific screen or handle the message data
    if (message.data.containsKey('screen')) {
      // Navigate to specific screen based on data
      // Navigator.pushNamed(context, message.data['screen']);
    }
  }

  // Handle terminated state messages
  void _handleTerminatedMessage(RemoteMessage message) {
    print('Handling terminated message: ${message.messageId}');
    // Handle the message data accordingly
  }

  // Handle notification tap
  void onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
    // Navigate to specific screen or handle the payload
  }
}