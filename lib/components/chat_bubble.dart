import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.chatText,
      required this.isSender,
      required this.product});

  final String chatText;
  final bool isSender;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget productPreview() {
      return Container(
        width: 230,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSender ? 12 : 0),
                topRight: Radius.circular(isSender ? 0 : 12),
                bottomLeft: const Radius.circular(12),
                bottomRight: const Radius.circular(12)),
            color: isSender ? tertiaryColor : backgroundSecondaryColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.gallery[0].url,
                    width: 70,
                    height: 70,
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
                        product.name,
                        style: primaryTextStyle.copyWith(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '\$${product.price}',
                        style: priceTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      cartProvider.updateCartProduct(
                        context.watch<AuthProvider>().user.token!,
                        product.id,
                        1,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        side: BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      'Add to Cart',
                      style: buttonTextStyle,
                    )),
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                        color: backgroundTertiaryColor, fontWeight: medium),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          product is UninitializedProductModel
              ? const SizedBox()
              : productPreview(),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isSender ? 12 : 0),
                          topRight: Radius.circular(isSender ? 0 : 12),
                          bottomLeft: const Radius.circular(12),
                          bottomRight: const Radius.circular(12)),
                      color:
                          isSender ? tertiaryColor : backgroundSecondaryColor),
                  child: Text(
                    chatText,
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
