
import 'package:firebase_messaging/firebase_messaging.dart';

/// Class Responsible for interacting with Firebase Cloud Messaging(FCM) REST API
class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



  initNotifications() async {
    // Request user the permission to receive Push Notification
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('=====FCM Token=====');
    print(token);

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message){
    print('======== onMessage ========= ');
    print('message: $message');
  }

  Future<dynamic> onBackgroundMessage(Map<String, dynamic> message){
    print('======== onMessage ========= ');
    print('message: $message');
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message){
    print('======== onMessage ========= ');
    print('message: $message');
  }

  Future<dynamic> onResume(Map<String, dynamic> message){
    print('======== onMessage ========= ');
    print('message: $message');
  }
}