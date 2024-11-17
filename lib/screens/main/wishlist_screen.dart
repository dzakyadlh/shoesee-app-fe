import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/components/wishlist_tile.dart';
import 'package:e_commerce_app/models/wishlist_model.dart';
import 'package:e_commerce_app/providers/screen_provider.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenProvider screenProvider = Provider.of(context);

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
                screenProvider.currentIndex = 0;
              })
        ],
      ));
    }

    Widget contents(List<WishlistedProduct> wishlists) {
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
        child: Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
          if (wishlistProvider.isLoading) {
            return const LoadingScreen();
          }

          return Column(
            children: [
              header(),
              wishlistProvider.wishlist.wishlistedProduct.isEmpty
                  ? emptyWishlist()
                  : contents(wishlistProvider.wishlist.wishlistedProduct)
            ],
          );
        }));
  }
}
