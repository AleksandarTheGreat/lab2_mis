import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/screen/ScreenCategories.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lab2_mis/service/ServiceFirebase.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidInit);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  showNotification(flutterLocalNotificationsPlugin);
  showScheduledNotification(flutterLocalNotificationsPlugin);

  GetIt.instance.registerSingleton(ServiceAPI());
  GetIt.instance.registerSingleton(ServiceFirebase());

  runApp(
    MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
      home: MyApp(),
    ),
  );
}

void showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    'default_channel',
    'Default',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(0, "Reminder", "This is a notification reminder to use the app", notificationDetails);
}

void showScheduledNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    'default_channel',
    'Default',
    importance: Importance.max,
    priority: Priority.high,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    "Reminder",
    "This is a notification reminder to use the app",
    tz.TZDateTime.now(tz.local).add(Duration(hours: 20)),
    NotificationDetails(
      android: androidNotificationDetails,
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );

  print("Notification scheduled in 20 hours");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenCategories();
  }
}
