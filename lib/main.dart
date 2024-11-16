import 'package:e_commerce_app/screens/cart_screen.dart';
import 'package:e_commerce_app/screens/checkout_screen.dart';
import 'package:e_commerce_app/screens/checkout_success_screen.dart';
import 'package:e_commerce_app/screens/edit_profile_screen.dart';
import 'package:e_commerce_app/screens/landing_screen.dart';
import 'package:e_commerce_app/screens/main/main_screen.dart';
import 'package:e_commerce_app/screens/signin_screen.dart';
import 'package:e_commerce_app/screens/signup_screen.dart';
import 'package:e_commerce_app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyD-qz2cfi9f859KnRTvxzCJRAfseGQMhks",
    appId: "1:529361243629:android:c4bd33512af5ee5de4ebe4",
    messagingSenderId: 'messagingSenderId',
    projectId: "shoe-commerce-app",
  ));
  runApp(const ProviderScope(child: MyApp()));
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
        '/main': (context) => const MainScreen(),
        '/cart': (context) => const CartScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/checkout-success': (context) => const CheckoutSuccessScreen()
      },
    );
  }
}
