import 'package:e_commerce_app/models/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_provider.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  List<ProductModel> build() {
    return [];
  }

  void setProduct(ProductModel product) {
    if (!isWishlisted(product)) {
      state = [...state, product]; // Add to wishlist
    } else {
      state = state
          .where((e) => e.id != product.id)
          .toList(); // Remove from wishlist
    }
  }

  bool isWishlisted(ProductModel product) {
    return state.indexWhere((e) => e.id == product.id) != -1;
  }
}
