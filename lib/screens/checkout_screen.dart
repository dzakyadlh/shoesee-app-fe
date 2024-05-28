import 'package:e_commerce_app/components/checkout_card.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: backgroundPrimaryColor,
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
            color: backgroundFourthColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address Details',
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
                          style: secondaryTextStyle.copyWith(
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
                              style: secondaryTextStyle.copyWith(
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

    Widget paymentSummary() {
      return Container(
        margin: EdgeInsets.only(bottom: defaultMargin),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundFourthColor),
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
                    style: secondaryTextStyle.copyWith(fontSize: 12)),
                Text(
                  '2 Items',
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
                    style: secondaryTextStyle.copyWith(fontSize: 12)),
                Text(
                  '\$575.96',
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
                    style: secondaryTextStyle.copyWith(fontSize: 12)),
                Text(
                  'Free',
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
                  '\$575.92',
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/checkout-success', (route) => false);
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

    Widget contents() {
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
              const CheckoutCard(),
              const CheckoutCard(),
              const CheckoutCard(),
              const SizedBox(
                height: 30,
              ),
              addressDetails(),
              paymentSummary(),
              const Divider(
                color: Color(0xFF2B2938),
              ),
              checkoutButton()
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundTertiaryColor,
      appBar: header(),
      body: contents(),
    );
  }
}
