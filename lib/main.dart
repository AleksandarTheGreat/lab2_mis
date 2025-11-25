import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lab2_mis/screen/ScreenCategories.dart';
import 'package:lab2_mis/service/ServiceAPI.dart';

void main() {
  GetIt.instance.registerSingleton(ServiceAPI());

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
