import 'package:e_commerce_app/components/cart_tile.dart';
import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            foregroundColor: primaryTextColor,
            backgroundColor: backgroundSecondaryColor,
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            title: Text(
              'Your Cart',
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
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
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
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
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium),
                ))
          ],
        ),
      );
    }

    Widget contents(CartModel cart) {
      return ListView(
        padding: EdgeInsets.only(
            bottom: defaultMargin, left: defaultMargin, right: defaultMargin),
        children: cart.cartProducts
            .map(
              (product) => CartTile(
                cartItem: product,
              ),
            )
            .toList(),
      );
    }

    Widget customBottomNavbar(CartProvider cartProvider) {
      return Wrap(children: [
        Column(
          children: [
            Container(
              margin:
                  EdgeInsets.only(right: defaultMargin, left: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    '\$${cartProvider.totalPrice()}',
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
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: defaultMargin,
                top: 16,
              ),
              width: double.infinity,
              height: 50,
              color: backgroundSecondaryColor,
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

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child:
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
        if (cartProvider.isLoading) {
          return const LoadingScreen();
        }
        return cartProvider.carts.cartProducts.isEmpty
            ? emptyCart()
            : contents(cartProvider.carts);
      })),
      bottomNavigationBar:
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
        if (cartProvider.isLoading) {
          return const SizedBox();
        }
        return cartProvider.carts.cartProducts.isEmpty
            ? const SizedBox()
            : customBottomNavbar(cartProvider);
      }),
    );
  }
}
