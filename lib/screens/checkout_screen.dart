import 'package:e_commerce_app/components/checkout_card.dart';
import 'package:e_commerce_app/components/loading_button.dart';
import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String address = 'Tokyo';
  double shippingPrice = 0.0;
  bool isLoading = false;

  Future<void> handleCheckout() async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    if (await transactionProvider.checkout(
        authProvider.user.token.toString(),
        cartProvider.carts,
        address,
        cartProvider.totalPrice(),
        shippingPrice)) {
      cartProvider.removeCart(authProvider.user.token!);
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/checkout-success',
          (route) => false,
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: backgroundSecondaryColor,
            foregroundColor: primaryTextColor,
            title: Text(
              'Checkout Details',
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
            ),
            centerTitle: true,
          ));
    }

    Widget addressDetails() {
      return Container(
        margin: EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundSecondaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address,
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_store.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    Dash(
                      direction: Axis.vertical,
                      length: 30,
                      dashLength: 4,
                      dashColor: primaryTextColor,
                    ),
                    Image.asset(
                      'assets/images/icon_address.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 12,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: subtitleTextStyle.copyWith(
                              fontSize: 12, fontWeight: light),
                        ),
                        Text(
                          'Adidas Store',
                          style: primaryTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Address',
                              style: subtitleTextStyle.copyWith(
                                  fontSize: 12, fontWeight: light),
                            ),
                            Text(
                              'Surabaya',
                              style: primaryTextStyle.copyWith(
                                  fontSize: 14, fontWeight: medium),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget paymentSummary(CartProvider cartProvider) {
      return Container(
        margin: EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundSecondaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product Quantity',
                    style: subtitleTextStyle.copyWith(fontSize: 12)),
                Text(
                  '${cartProvider.totalItems()} Items',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: medium),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Product Price',
                    style: subtitleTextStyle.copyWith(fontSize: 12)),
                Text(
                  '\$${cartProvider.totalPrice()}',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: medium),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping',
                    style: subtitleTextStyle.copyWith(fontSize: 12)),
                Text(
                  shippingPrice == 0 ? 'Free' : '\$$shippingPrice',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: medium),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              color: Color(0xFF2E3141),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: priceTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
                Text(
                  '\$${(cartProvider.totalPrice()) + shippingPrice}',
                  style: priceTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget checkoutButton() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        width: double.infinity,
        height: 50,
        child: FilledButton(
          onPressed: () {
            handleCheckout();
          },
          style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            'Checkout Now',
            style:
                primaryTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
          ),
        ),
      );
    }

    Widget contents(CartProvider cartProvider) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Items',
                style:
                    primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: cartProvider.carts.cartProducts
                    .map((product) => CheckoutCard(
                          cartItem: product,
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              addressDetails(),
              paymentSummary(cartProvider),
              const Divider(
                color: Color(0xFF2B2938),
              ),
              isLoading ? const LoadingButton() : checkoutButton()
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundPrimaryColor,
      appBar: header(),
      body: SafeArea(child:
          Consumer<CartProvider>(builder: (context, cartProvider, child) {
        if (cartProvider.isLoading) {
          return const LoadingScreen();
        }
        return contents(cartProvider);
      })),
    );
  }
}
