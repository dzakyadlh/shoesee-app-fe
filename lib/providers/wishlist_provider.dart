import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishlist = [];

  List<ProductModel> get wishlist => _wishlist;

  set wishlist(List<ProductModel> wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }

  setProduct(ProductModel product) {
    if (!isWishlisted(product)) {
      _wishlist.add(product);
    } else {
      _wishlist.removeWhere((e) => e.id == product.id);
    }

    notifyListeners();
  }

  isWishlisted(ProductModel product) {
    if (_wishlist.indexWhere((e) => e.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
