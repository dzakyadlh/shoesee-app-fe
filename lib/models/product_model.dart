import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/gallery_model.dart';

class ProductModel {
  int id;
  String name;
  double price;
  String description;
  String? tags;
  CategoryModel category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> gallery;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.tags,
      required this.category,
      required this.createdAt,
      required this.updatedAt,
      required this.gallery});

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        price = json['price'] is int
            ? (json['price'] as int).toDouble()
            : (json['price'] as double? ?? 0.0),
        description = json['description'] ?? '',
        tags = json['tags'],
        category = json['category'] is Map<String, dynamic>
            ? CategoryModel.fromJson(json['category'])
            : CategoryModel(id: 0, name: ''),
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        gallery = json['gallery'] != null
            ? (json['gallery'] as List)
                .map((item) => GalleryModel.fromJson(item))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'gallery': gallery.map((gallery) => gallery.toJson()).toList()
    };
  }
}
