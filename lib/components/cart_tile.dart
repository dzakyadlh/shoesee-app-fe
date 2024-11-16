import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartTile extends ConsumerStatefulWidget {
  const CartTile({super.key, required this.cartItem});

  final CartProduct cartItem;

  @override
  ConsumerState<CartTile> createState() => _CartTileState();
}

class _CartTileState extends ConsumerState<CartTile> {
  @override
  Widget build(BuildContext context) {
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
                      ref.read(cartNotifierProvider.notifier).updateCartProduct(
                            ref.watch(authNotifierProvider).value!.token!,
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
                    widget.cartItem.quantity.toString(),
                    style: primaryTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(cartNotifierProvider.notifier).updateCartProduct(
                            ref.watch(authNotifierProvider).value!.token!,
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
