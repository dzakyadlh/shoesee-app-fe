import 'package:e_commerce_app/models/wishlist_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class WishlistTile extends StatefulWidget {
  const WishlistTile({super.key, required this.product});

  final WishlistedProduct product;

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    AuthProvider authProvider = Provider.of(context);

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
              widget.product.gallery[0].url,
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
                  widget.product.name,
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                Text(
                  '\$${widget.product.price}',
                  style:
                      priceTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              wishlistProvider.removeWishlist(
                authProvider.user.token!,
                widget.product.productId,
              );
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
