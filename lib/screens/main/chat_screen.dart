import 'package:e_commerce_app/components/chat_tile.dart';
import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/models/message_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/screen_provider.dart';
import 'package:e_commerce_app/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider);
    Widget header() {
      return AppBar(
        backgroundColor: backgroundSecondaryColor,
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
        color: backgroundPrimaryColor,
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
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
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
                onPressed: () {
                  ref.read(screenNotifierProvider.notifier).setCurrentIndex(0);
                })
          ],
        ),
      ));
    }

    Widget contents() {
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(userId: user.value!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while data is loading
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color:
                      secondaryColor, // You can customize the color as needed
                ),
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return emptyChat();
            }
            return Expanded(
              child: Container(
                padding: EdgeInsets.all(defaultMargin),
                color: backgroundPrimaryColor,
                child: Column(
                  children: [
                    ChatTile(
                      message: snapshot.data![snapshot.data!.length - 1],
                    )
                  ],
                ),
              ),
            );
          } else {
            // Handle error or show empty state if needed
            return emptyChat();
          }
        },
      );
    }

    return Container(
      color: backgroundPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [header(), contents()],
      ),
    );
  }
}
