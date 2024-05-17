import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Chat',
          style: primaryTextStyle,
        )
      ],
    );
  }
}
