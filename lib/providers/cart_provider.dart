import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  CartModel _carts = CartModel(id: 0, userId: 0, cartProducts: []);
  CartModel get carts => _carts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set carts(CartModel carts) {
    _carts = carts;
    notifyListeners();
  }

  Future<void> getCartProducts(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _carts = await CartService().getCart(token);
    } catch (e) {
      debugPrint('Fetching error: $e');
      throw Exception('Failed to load cart data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update the quantity of a product and update state
  Future<void> updateCartProduct(
      String token, int productId, int quantity) async {
    _isLoading = true;
    notifyListeners();
    try {
      _carts =
          await CartService().updateCartProduct(token, productId, quantity);
    } catch (e) {
      debugPrint('Cart update error: $e');
      throw Exception('Failed to update cart data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Remove a product from the cart and update state
  Future<void> removeCart(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _carts = await CartService().removeCart(token);
    } catch (e) {
      debugPrint('Removing error: $e');
      throw Exception('Failed to remove cart product');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  double totalPrice() {
    if (_carts.cartProducts.isEmpty) {
      return 0.0;
    }
    double total = _carts.cartProducts
        .fold(0, (prev, current) => prev + (current.price * current.quantity));
    return total;
  }

  double totalItems() {
    if (_carts.cartProducts.isEmpty) {
      return 0.0;
    }
    double total =
        _carts.cartProducts.fold(0, (prev, current) => prev + current.quantity);
    return total;
  }
}
