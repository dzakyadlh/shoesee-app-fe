import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:e_commerce_app/components/wishlist_tile.dart';
import 'package:e_commerce_app/providers/screen_provider.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlists = ref.read(wishlistNotifierProvider);

    Widget header() {
      return AppBar(
        backgroundColor: backgroundSecondaryColor,
        centerTitle: true,
        title: Text(
          'Favorite Shoes',
          style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget emptyWishlist() {
      return Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            color: primaryColor,
            size: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Oops! No dream shoes yet!',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Let\'s find your favorite shoes',
            style: subtitleTextStyle.copyWith(fontSize: 14),
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
      ));
    }

    Widget contents() {
      return Expanded(
        child: Container(
            padding: EdgeInsets.all(defaultMargin),
            child: ListView(
              children: wishlists
                  .map((product) => WishlistTile(
                        product: product,
                      ))
                  .toList(),
            )),
      );
    }

    return Container(
      color: backgroundPrimaryColor,
      child: Column(
        children: [header(), wishlists.isEmpty ? emptyWishlist() : contents()],
      ),
    );
  }
}
