import 'dart:io';

import 'package:cndv/src/models/push_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';


/// Class Responsible for interacting with Firebase Cloud Messaging(FCM) REST API
class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  /// For handle background notifications we need to define a static or Top-Level function (Outside of any class)
  /// and define the onBackgroundMessage property inside the _firebaseMessaging.configure method
  static Future<dynamic> firebaseMessagingBackgroundHandler(
      Map<String, dynamic> message,
      ) async {
    // Initialize the Firebase App

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic data = message['notification'];
    }

    print('onBackgroundMessage received: $message');
  }

  initNotifications() async {

    // Request user the permission to receive Push Notification (only required for iOS)
    if(Platform.isIOS) {
      await _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        ),
      );
    }

    final token = await _firebaseMessaging.getToken();
    print('=====FCM Token=====');
    print(token);

    _firebaseMessaging.configure(
        onMessage: onMessage,
        onBackgroundMessage: firebaseMessagingBackgroundHandler,
        onLaunch: onLaunch,
        onResume: onResume);
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) {
    print('======== onMessage ========= ');
    print('message: $message');

    PushNotification notification = PushNotification.fromJson(message);

    showSimpleNotification(
      Text(notification.title),
      subtitle: Text('Go go go test'),
      background: Colors.blueAccent,
      duration: Duration(seconds: 2),
    );
  }

  Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) {
    print('======== onMessage ========= ');
    print('message: $message');
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) {
    print('======== onMessage ========= ');
    print('message: $message');
  }

  Future<dynamic> onResume(Map<String, dynamic> message) {
    print('======== onMessage ========= ');
    print('message: $message');
  }
}
