import 'package:e_commerce_app/models/gallery_model.dart';

class WishlistModel {
  int id;
  int userId;
  List<WishlistedProduct> wishlistedProduct;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.wishlistedProduct,
  });

  WishlistModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        wishlistedProduct = (json['wishlists'] as List)
            .map((item) => WishlistedProduct.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'wishlists':
          wishlistedProduct.map((product) => product.toJson()).toList(),
    };
  }
}

class WishlistedProduct {
  int productId;
  String name;
  double price;
  List<GalleryModel> gallery;

  WishlistedProduct({
    required this.productId,
    required this.name,
    required this.price,
    required this.gallery,
  });

  WishlistedProduct.fromJson(Map<String, dynamic> json)
      : productId = json['product_id'],
        name = json['name'],
        price = double.parse(json['price'].toString()),
        gallery = (json['gallery'] as List)
            .map((item) => GalleryModel.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'gallery': gallery.map((e) => e.toJson()).toList(),
    };
  }
}
