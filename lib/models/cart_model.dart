import 'package:e_commerce_app/models/gallery_model.dart';

class CartModel {
  int id;
  int userId;
  List<CartProduct> cartProducts;

  CartModel({
    required this.id,
    required this.userId,
    required this.cartProducts,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        cartProducts = (json['cart_products'] as List)
            .map((item) => CartProduct.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'cart_products': cartProducts.map((product) => product.toJson()).toList(),
    };
  }

  double getTotalPrice() {
    return cartProducts.fold(
        0.0, (total, item) => total + item.getTotalPrice());
  }
}

class CartProduct {
  int productId;
  String name;
  double price;
  int quantity;
  List<GalleryModel> gallery;

  CartProduct({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.gallery,
  });

  CartProduct.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        name = json['name'],
        price = json['price'],
        quantity = json['quantity'],
        gallery = (json['gallery'] as List)
            .map((item) => GalleryModel.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'gallery': gallery.map((e) => e.toJson()).toList(),
    };
  }

  double getTotalPrice() {
    return price * quantity;
  }
}
