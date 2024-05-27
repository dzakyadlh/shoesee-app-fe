import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  int productAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(top: defaultMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundFourthColor),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/shoe_1.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terrex Urban Low',
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: semibold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '\$143.98',
                      style: priceTextStyle.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        productAmount++;
                      });
                    },
                    child: Image.asset(
                      'assets/images/btn_add.png',
                      width: 16,
                      height: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    productAmount.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (productAmount > 0) {
                          productAmount--;
                        }
                      });
                    },
                    child: Image.asset(
                      'assets/images/btn_drop.png',
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: alertColor,
                  size: 14,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Remove',
                  style:
                      alertTextStyle.copyWith(fontSize: 12, fontWeight: light),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
