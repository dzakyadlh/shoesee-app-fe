import 'package:e_commerce_app/models/message_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.message});

  final MessageModel message;

  lastToDate() {
    DateTime today = DateTime.now();
    int difference = today.difference(message.createdAt).inDays;
    DateTime firstDayOfNextMonth = (today.month < 12)
        ? DateTime(today.year, today.month + 1, 1)
        : DateTime(today.year + 1, 1, 1);
    int daysThisMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1)).day;
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < daysThisMonth) {
      return '$difference + days ago';
    } else if (difference > 365) {
      return 'More than a year ago';
    } else if (difference > daysThisMonth) {
      return 'More than a month ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatDetailScreen(product: UninitializedProductModel())));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF2B2939)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/shop.png',
                height: 54,
                width: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shoe Store',
                    style: primaryTextStyle.copyWith(fontSize: 15),
                  ),
                  Text(
                    message.message,
                    style: secondaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: light),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              '${lastToDate()}',
              style: secondaryTextStyle.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

class UserChatTile extends StatelessWidget {
  const UserChatTile({super.key, required this.chatText});

  final String chatText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: tertiaryColor),
      child: Text(chatText),
    );
  }
}
