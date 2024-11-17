import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('userToken');
    if (mounted) {
      // Delay for splash effect
      await Future.delayed(const Duration(seconds: 3));

      // Navigate based on the presence of a user token
      if (mounted) {
        if (token != null) {
          await ref.read(authNotifierProvider.notifier).loadUserSession();
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
          }
        } else {
          Navigator.pushNamed(context, '/landing');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'))),
        ),
      ),
    );
  }
}
