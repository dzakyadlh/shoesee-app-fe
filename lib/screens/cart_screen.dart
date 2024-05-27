import 'package:e_commerce_app/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartItems = ['any'];

  PreferredSizeWidget header() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          foregroundColor: primaryTextColor,
          backgroundColor: backgroundPrimaryColor,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          title: Text(
            'Your Cart',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          centerTitle: true,
        ));
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            color: secondaryColor,
            size: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Oops! Your Cart is Empty!',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Let\'s find your dream shoes',
            style: secondaryTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
              },
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: primaryColor),
              child: Text(
                'Explore Store',
                style:
                    primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ))
        ],
      ),
    );
  }

  Widget contents() {
    return ListView(
      padding: EdgeInsets.only(
          bottom: defaultMargin, left: defaultMargin, right: defaultMargin),
      children: const [CartTile()],
    );
  }

  Widget customBottomNavbar() {
    return Wrap(children: [
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: defaultMargin,
                right: defaultMargin,
                left: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: primaryTextStyle.copyWith(fontSize: 14),
                ),
                Text(
                  '\$287.96',
                  style: priceTextStyle.copyWith(
                      fontSize: 16, fontWeight: semibold),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color(0xFF2B2938),
          ),
          Container(
            margin: EdgeInsets.all(defaultMargin),
            width: double.infinity,
            height: 50,
            child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                style: FilledButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue to Checkout',
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: semibold),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: primaryTextColor,
                      size: 20,
                    )
                  ],
                )),
          )
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundTertiaryColor,
      resizeToAvoidBottomInset: false,
      body: contents(),
      bottomNavigationBar: customBottomNavbar(),
    );
  }
}
