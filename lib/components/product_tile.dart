import 'package:e_commerce_app/models/product_model.dart';
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
        Navigator.pushNamed(context, '/product');
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
                    : "http://e-commerce-backend.test/storage/gallery/eCb0D1Co2QPkxBgHnNkug8sCPZK4Cqo2pfRxxXbC.png",
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
                  product.category.toString(),
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
