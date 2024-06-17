import 'package:e_commerce_app/components/chat_bubble.dart';
import 'package:e_commerce_app/models/message_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class ChatDetailScreen extends StatefulWidget {
  ChatDetailScreen({super.key, required this.product});

  ProductModel product;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController chatController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSend() async {
      await MessageService().addMessage(
        user: authProvider.user,
        isFromUser: true,
        message: chatController.text,
        product: widget.product,
      );

      setState(() {
        widget.product = UninitializedProductModel();
        chatController.text = '';
      });
    }

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
              child: Image.network(
                widget.product.gallery[0].url,
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
                    widget.product.name,
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: priceTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.product = UninitializedProductModel();
                });
              },
              child: Image.asset(
                'assets/images/btn_close.png',
                width: 22,
              ),
            )
          ],
        ),
      );
    }

    Widget chatInput() {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: backgroundTertiaryColor,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.product is UninitializedProductModel
                  ? const SizedBox()
                  : productPreview(),
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
                        controller: chatController,
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
                    onTap: () {
                      handleSend();
                    },
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
        ),
      );
    }

    Widget contents() {
      return StreamBuilder<List<MessageModel>>(
        stream:
            MessageService().getMessagesByUserId(userId: authProvider.user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text('Error: ${snapshot.error}'),
                  Text('Error: ${snapshot.data}'),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No messages yet'),
            );
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              children: snapshot.data!
                  .map((MessageModel message) => ChatBubble(
                        chatText: message.message,
                        isSender: message.isFromUser,
                        product: widget.product,
                      ))
                  .toList(),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundTertiaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(child: contents()),
      ),
      bottomNavigationBar: chatInput(),
    );
  }
}
