import 'package:e_commerce_app/screens/landing.dart';
import 'package:e_commerce_app/screens/signin.dart';
import 'package:e_commerce_app/screens/signup.dart';
import 'package:e_commerce_app/screens/splash.dart';
import 'package:e_commerce_app/screens/store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/landing': (context) => const LandingScreen(),
        '/signin': (context) => const SigninScreen(),
        '/signup': (context) => const SignupScreen(),
        '/store': (context) => const StoreScreen(),
        '/cart': (context) => const LandingScreen(),
      },
    );
  }
}
