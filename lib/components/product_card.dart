import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/product_screen.dart';
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(product: product)));
      },
      child: Container(
        width: 215,
        height: 278,
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
                  : "https://firebasestorage.googleapis.com/v0/b/gradee-b80f3.appspot.com/o/mathematics_hs.jpg?alt=media&token=0c870127-71e9-49c8-afe0-00cd0be2bc9a",
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
                    product.category.name,
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name,
                    style: secondaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: semibold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '\$${product.price}',
                    style:
                        priceTextStyle.copyWith(fontSize: 14, fontWeight: bold),
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
