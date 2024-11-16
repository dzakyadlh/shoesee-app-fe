import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistTile extends ConsumerWidget {
  const WishlistTile({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 10, left: 12, bottom: 14, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundFourthColor,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.gallery[0].url,
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
                  product.name,
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                Text(
                  '\$${product.price}',
                  style:
                      priceTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(wishlistNotifierProvider.notifier).setProduct(product);
            },
            icon: Icon(
              Icons.favorite,
              color: primaryTextColor,
              size: 16,
            ),
            style: IconButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          )
        ],
      ),
    );
  }
}
