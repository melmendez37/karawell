import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService{
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService(){
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin
  = FlutterLocalNotificationsPlugin();

  void onSelectNotification(NotificationResponse response) {
    // Handle the notification tap
    print("Notification Clicked: ${response.payload}");
  }

  Future<void> initNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    const AndroidInitializationSettings  androidInitializationSettings
    = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: androidInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

  }

  Future<void> schedNotifications(DateTime selectedTime) async {
    if(selectedTime.isBefore(DateTime.now())){
      selectedTime = selectedTime.add(const Duration(seconds: 10));
    }

    final tz.TZDateTime schedTime = tz.TZDateTime.from(selectedTime, tz.local);

    NotificationDetails androidNotificationDetails() {
      return NotificationDetails(
          android: AndroidNotificationDetails(
              'channelId',
              'channelName',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true
          )
      );
    }

    try{
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          0,
          "notif title",
          "notif body",
          schedTime,
          androidNotificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time
      );
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }

    NotificationDetails _notificationDetails() {
      return NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        ),
      );
    }

  }
}