import 'package:e_commerce_app/components/chat_tile.dart';
import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> chats = ['Hello'];

  Widget header() {
    return AppBar(
      backgroundColor: backgroundPrimaryColor,
      centerTitle: true,
      title: Text(
        'Message Support',
        style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget emptyChat() {
    return Expanded(
        child: Container(
      color: backgroundTertiaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.headset_mic,
            color: secondaryColor,
            size: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Oops! No message yet',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'You have never done a transaction',
            style: secondaryTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFilledButton(
              buttonHeight: 44,
              buttonText: 'Explore Store',
              buttonTextSize: 16,
              onPressed: () {})
        ],
      ),
    ));
  }

  Widget contents() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(defaultMargin),
      color: backgroundTertiaryColor,
      child: const Column(
        children: [ChatTile()],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundTertiaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [header(), chats == [] ? emptyChat() : contents()],
      ),
    );
  }
}
