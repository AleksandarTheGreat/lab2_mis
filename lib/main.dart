import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/screen/ScreenCategories.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:lab2_mis/service/ServiceFirebase.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.instance.registerSingleton(ServiceAPI());
  GetIt.instance.registerSingleton(ServiceFirebase());

  runApp(
    MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange)),
      home: MyApp(),
    ),
  );
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
