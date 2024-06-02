import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Container(
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
            Image.network(
              product.gallery.isNotEmpty
                  ? product.gallery[0].url
                  : "http://e-commerce-backend.test/storage/gallery/eCb0D1Co2QPkxBgHnNkug8sCPZK4Cqo2pfRxxXbC.png",
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
                    product.category.toString(),
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: subtitleTextStyle.copyWith(
                        fontSize: 18, fontWeight: semibold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '\$${product.price}',
                    style: priceTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
