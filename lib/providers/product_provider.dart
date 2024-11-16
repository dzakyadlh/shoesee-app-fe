import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  AsyncValue<List<ProductModel>> build() {
    return const AsyncLoading(); // Start with loading state
  }

  // Fetch products asynchronously and update the state
  Future<void> getProducts() async {
    try {
      // Fetch products from the service
      List<ProductModel> products = await ProductService().getProducts();
      state = AsyncData(products); // Update with fetched products
    } catch (e, stackTrace) {
      // Handle error and update state with error
      debugPrint('Fetching error: $e');
      state = AsyncError(e.toString(), stackTrace);
    }
  }

  // Filter products by category
  void filterProductsByCategory(int categoryId) {
    if (state is AsyncData<List<ProductModel>>) {
      final List<ProductModel> allProducts =
          (state as AsyncData<List<ProductModel>>).value;
      final filtered = allProducts
          .where((product) => product.category.id == categoryId)
          .toList();
      state = AsyncData(filtered); // Update with filtered products
    }
  }

  // Clear the filter and reset the product list
  void clearFilter() {
    if (state is AsyncData<List<ProductModel>>) {
      final List<ProductModel> allProducts =
          (state as AsyncData<List<ProductModel>>).value;
      state = AsyncData(allProducts); // Reset to the original list
    }
  }
}
