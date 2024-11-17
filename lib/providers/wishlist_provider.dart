import 'package:e_commerce_app/models/wishlist_model.dart';
import 'package:e_commerce_app/services/wishlist_service.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  WishlistModel _wishlist =
      WishlistModel(id: 0, userId: 0, wishlistedProduct: []);
  WishlistModel get wishlist => _wishlist;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set wishlist(WishlistModel wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }

  Future<void> getWishlists(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _wishlist = await WishlistService().getWishlists(token);
    } catch (e) {
      debugPrint('Fetching error: $e');
      throw Exception('Failed to load wishlist data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addWishlist(String token, int productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _wishlist = await WishlistService().addWishlist(token, productId);
    } catch (e) {
      debugPrint('Updating error: $e');
      throw Exception('Failed to add wishlist data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeWishlist(String token, int productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _wishlist = await WishlistService().removeWishlist(token, productId);
    } catch (e) {
      debugPrint('Updating error: $e');
      throw Exception('Failed to remove wishlist data');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isWishlisted(int productId) {
    return _wishlist.wishlistedProduct
        .any((product) => product.productId == productId);
  }
}
