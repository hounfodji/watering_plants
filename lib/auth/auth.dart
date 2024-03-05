import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watering_plants/auth/login_or_register.dart';
import 'package:watering_plants/main.dart';
import 'package:watering_plants/pages/device_page.dart';
import 'package:watering_plants/pages/intro_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: ((context, snapshot) {
        // user is logged in
        if (snapshot.hasData){
          return DevicePage();
        }

        // user isn't logged in
        else {
          return const LoginOrRegister();
        }
      })),
    );
  }
}