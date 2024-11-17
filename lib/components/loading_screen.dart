import 'package:e_commerce_app/theme.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ) // Show loading indicator while
          ),
    ]);
  }
}
