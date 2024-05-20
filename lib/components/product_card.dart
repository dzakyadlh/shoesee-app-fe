import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final String product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      height: 278,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFECEDEF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultMargin,
          ),
          Image.asset(
            'assets/images/shoe_1.png',
            width: 215,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: defaultMargin,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hiking',
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  product,
                  style: subtitleTextStyle.copyWith(
                      fontSize: 18, fontWeight: semibold),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '\$143.98',
                  style:
                      priceTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
