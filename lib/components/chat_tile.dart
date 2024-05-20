import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/chat');
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
                    'Good Night, This item is on sale right now',
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
              'Now',
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
