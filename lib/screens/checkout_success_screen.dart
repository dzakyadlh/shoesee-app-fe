import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: backgroundSecondaryColor,
            title: Text(
              'Checkout Success',
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semibold),
            ),
            centerTitle: true,
            elevation: 0,
          ));
    }

    Widget contents() {
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
              'You made a transaction!',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Stay at home while we\nprepare your dream shoes',
              style: subtitleTextStyle.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 200,
              height: 44,
              child: FilledButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                  },
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: primaryColor),
                  child: Text(
                    'Order Other Shoes',
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 200,
              height: 44,
              child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF39374B)),
                  child: Text(
                    'View Order',
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  )),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: header(),
        backgroundColor: backgroundPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: contents()));
  }
}
