import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          foregroundColor: primaryTextColor,
          backgroundColor: backgroundPrimaryColor,
          centerTitle: false,
          elevation: 1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/shop_online.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shoe Store',
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: medium),
                    ),
                    Text(
                      'Online',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: light),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget productPreview() {
      return Container(
        width: 225,
        height: 74,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(12),
          color: tertiaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/shoe_1.png',
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COURT VISION',
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    '\$57.15',
                    style: priceTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/btn_close.png',
              width: 22,
            )
          ],
        ),
      );
    }

    Widget chatInput() {
      return Container(
        color: backgroundTertiaryColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: backgroundSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: TextFormField(
                      // controller: chatController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Message', hintStyle: subtitleTextStyle),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 45,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor),
                    child: Icon(
                      Icons.send,
                      color: primaryTextColor,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundTertiaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: const Column(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: chatInput(),
    );
  }
}
