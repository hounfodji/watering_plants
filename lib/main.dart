import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watering_plants/auth/auth.dart';
import 'package:watering_plants/auth/login_or_register.dart';
import 'package:watering_plants/firebase_options.dart';
import 'package:watering_plants/pages/add_device.dart';
import 'package:watering_plants/pages/add_schedule_page.dart';
import 'package:watering_plants/pages/device_details_page.dart';
import 'package:watering_plants/pages/device_page.dart';
import 'package:watering_plants/pages/history_page.dart';
import 'package:watering_plants/pages/intro_page.dart';
import 'package:watering_plants/pages/schedule_page.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        "/login_register_page": (context) => LoginOrRegister(),
        "/auth_page": (context) => AuthPage(),
        '/intropage' : (context) => const IntroPage(),
        '/devicepage' : (context) => const DevicePage(),
        '/schedulepage' : (context) => const SchedulePage(),
        '/historypage' : (context) => const HistoryPage(),
        '/adddevicepage' : (context) => const AddDevicePage(),
        '/addschedulepage' : (context) => const AddSchedulePage(),
        // '/devicedetailpage' : (context) => const DeviceDetailsPage(),
      },
    );
  }
}