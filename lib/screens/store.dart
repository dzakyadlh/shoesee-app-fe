import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: const Column(
            children: [Text('data')],
          ),
        ),
      ),
    );
  }
}
