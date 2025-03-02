import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  //initialize
  Future<void> initNotification() async {
    if(_isInitialized) return; //avoid re-init

    //init timezone handling
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    //prepare android init settings
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    //init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    //init the plugin
    await notificationsPlugin.initialize(initSettings);

    _isInitialized = true;
    print("Notifications Initialized: ${_isInitialized}");

  }

  //notification detail setup
  NotificationDetails notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'karawellChannel',
          'Daily notifications',
          channelDescription: 'Daily Notification Channel',
          importance: Importance.max,
          priority: Priority.high
      ),
    );
  }

  // Future<void> requestPermissions() async {
  //   await notificationsPlugin
  //       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestPermission();
  // }

  //show immediate notifications
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  //schedule notifications at a specific time (ex. 10am) hour (0-23) minute (0-59)
  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute
  }) async {
    //get current date/time in devices local timezone
    final now = tz.TZDateTime.now(tz.local);

    //create a date/time for today at a specific hour/min
    var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
    );

    // If the time is in the past, schedule for the next day
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    //schedule notification
    await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notificationDetails(),

        //ios specific
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

        //android specific: allow notifcation while device is low power
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        //make notification repeat DAILY at the same time
        matchDateTimeComponents: DateTimeComponents.time,
    );

    print("scheduled for $scheduledDate");

  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }


}