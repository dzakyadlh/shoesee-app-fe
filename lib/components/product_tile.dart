import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
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
        height: 120,
        margin: EdgeInsets.only(bottom: defaultMargin),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.gallery.isNotEmpty
                    ? product.gallery[0].url
                    : "https://firebasestorage.googleapis.com/v0/b/gradee-b80f3.appspot.com/o/mathematics_hs.jpg?alt=media&token=0c870127-71e9-49c8-afe0-00cd0be2bc9a",
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semibold),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '\$${product.price}',
                  style:
                      priceTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
