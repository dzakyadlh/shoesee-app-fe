import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.cartItem});

  final CartProduct cartItem;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    final productQuantity = context
        .read<CartProvider>()
        .carts
        .cartProducts
        .firstWhere((item) => item.productId == widget.cartItem.productId)
        .quantity;

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(top: defaultMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundSecondaryColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.cartItem.gallery[0].url,
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
                      widget.cartItem.name,
                      style: primaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: semibold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '\$${widget.cartItem.price}',
                      style: priceTextStyle.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.updateCartProduct(
                        authProvider.user.token!,
                        widget.cartItem.productId,
                        1,
                      );
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
                    '$productQuantity',
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      cartProvider.updateCartProduct(
                        authProvider.user.token!,
                        widget.cartItem.productId,
                        -1,
                      );
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
            onTap: () {
              cartProvider.updateCartProduct(
                authProvider.user.token!,
                widget.cartItem.productId,
                -productQuantity,
              );
            },
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
