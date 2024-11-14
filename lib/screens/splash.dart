import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('userToken');
    if (mounted) {
      // await Provider.of<AuthProvider>(context, listen: false).logout();
      // Load user session in AuthProvider
      await Provider.of<AuthProvider>(context, listen: false).loadUserSession();

      // Optionally load products (if needed for initial display)
      await Provider.of<ProductProvider>(context, listen: false).getProducts();

      // Delay for splash effect
      await Future.delayed(const Duration(seconds: 3));

      // Navigate based on the presence of a user token
      if (mounted) {
        if (token != null) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
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
