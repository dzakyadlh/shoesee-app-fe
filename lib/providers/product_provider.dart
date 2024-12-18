import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _filteredProducts = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();

      _products = products;
    } catch (e) {
      debugPrint('Fetching error: $e');
    }
  }

  void filterProductsByCategory(int categoryId) {
    _filteredProducts = _products
        .where((product) => product.category.id == categoryId)
        .toList();
    notifyListeners();
  }

  void clearFilter() {
    _filteredProducts = [];
    notifyListeners();
  }
}
