import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mylk/model/task_notification_model.dart';
import 'package:rxdart/subjects.dart';

final BehaviorSubject<TaskNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<TaskNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  "0",
  'Reminder notifications',
  'Mylk task reminders',
  icon: 'app_icon',
);
final iOSPlatformChannelSpecifics = IOSNotificationDetails();
final platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(TaskNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
}

Future<void> showNotification(
    int id, String title, String body, {String payload = ""}) async {
  await _flutterLocalNotificationsPlugin
      .show(id, title, body, platformChannelSpecifics, payload: payload);
}

Future<void> turnOffNotification() async {
  await _flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> turnOffNotificationById(int id) async {
  await _flutterLocalNotificationsPlugin.cancel(id);
}

Future<void> scheduleNotification(
    int id, String body, DateTime scheduledNotificationDateTime,
    {String title = "Mylk reminder"}) async {
  await _flutterLocalNotificationsPlugin.schedule(
      id, title, body, scheduledNotificationDateTime, platformChannelSpecifics);
}

Future<void> scheduleNotificationPeriodically(
    int id,
    String body,
    RepeatInterval interval,
{String title = "Mylk reminder"}) async {
  await _flutterLocalNotificationsPlugin.periodicallyShow(
      id, title, body, interval, platformChannelSpecifics);
}

void requestIOSPermissions() {
  _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}
