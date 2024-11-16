import 'package:e_commerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({super.key, required this.cartItem});

  final CartProduct cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundSecondaryColor,
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              cartItem.gallery[0].url,
              width: 60,
              height: 60,
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
                  cartItem.name,
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '\$${cartItem.price}',
                  style: priceTextStyle.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
          Text(
            '${cartItem.quantity} items',
            style: subtitleTextStyle.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
