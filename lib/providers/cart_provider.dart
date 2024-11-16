import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  AsyncValue<List<CartProduct>> build() {
    return const AsyncValue.loading();
  }

  // Fetch cart products and update state with AsyncValue
  Future<void> getCartProducts(String token) async {
    try {
      state = const AsyncValue.loading(); // Set loading state
      List<CartProduct> cartProducts = await CartService().getCart(token);
      state = AsyncValue.data(cartProducts); // Set data state
    } catch (e, stackTrace) {
      debugPrint('Fetching error: $e');
      state = AsyncValue.error(e, stackTrace); // Set error state
      throw Exception('Failed to load cart data');
    }
  }

  // Update the quantity of a product and update state
  Future<void> updateCartProduct(
      String token, int productId, int quantity) async {
    try {
      await CartService().updateCartProduct(token, productId, quantity);
      await getCartProducts(token);
    } catch (e, stackTrace) {
      debugPrint('Cart update error: $e');
      state = AsyncValue.error(e, stackTrace); // Set error state
      throw Exception('Failed to update cart data');
    }
  }

  // Remove a product from the cart and update state
  Future<void> removeCartProduct(String token, int productId) async {
    try {
      await CartService().removeCartProduct(token, productId);
      await getCartProducts(token);
    } catch (e, stackTrace) {
      debugPrint('Removing error: $e');
      state = AsyncValue.error(e, stackTrace); // Set error state
      throw Exception('Failed to remove cart product');
    }
  }

  Future<double> totalPrice() async {
    if (state.value == null) {
      return 0.0;
    }
    double total = state.value!
        .fold(0, (prev, current) => prev + (current.price * current.quantity));
    return total;
  }

  Future<double> totalItems() async {
    if (state.value == null) {
      return 0.0;
    }
    double total =
        state.value!.fold(0, (prev, current) => prev + current.quantity);
    return total;
  }
}
