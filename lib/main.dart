import 'package:flutter/material.dart';
import 'package:watering_plants/pages/device_page.dart';
import 'package:watering_plants/pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      routes: {
        '/intropage' : (context) => const IntroPage(),
        '/devicepage' : (context) => const DevicePage(),
      },
    );
  }
}