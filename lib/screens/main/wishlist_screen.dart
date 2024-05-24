import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:e_commerce_app/components/wishlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<String> wishlists = ['a'];

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundPrimaryColor,
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
            color: secondaryColor,
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
            style: secondaryTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFilledButton(
              buttonHeight: 44,
              buttonText: 'Explore Store',
              buttonTextSize: 16,
              onPressed: () {})
        ],
      ));
    }

    Widget contents() {
      return Expanded(
        child: Container(
            padding: EdgeInsets.all(defaultMargin),
            child: ListView(
              children: const [WishlistTile(), WishlistTile()],
            )),
      );
    }

    return Container(
      color: backgroundTertiaryColor,
      child: Column(
        children: [header(), wishlists == [] ? emptyWishlist() : contents()],
      ),
    );
  }
}
