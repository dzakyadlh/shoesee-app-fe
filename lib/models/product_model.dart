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

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.tags,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.gallery,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = double.parse(json['price'].toString()),
        description = json['description'],
        tags = json['tags'],
        category = CategoryModel.fromJson(json['categories']),
        gallery = (json['gallery'] as List)
            .map((item) => GalleryModel.fromJson(item))
            .toList(),
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags.toString(),
      'category': category.toJson(),
      'gallery': gallery.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class UninitializedProductModel extends ProductModel {
  UninitializedProductModel()
      : super(
          id: 0,
          name: '',
          price: 0.0,
          description: '',
          tags: null,
          category: CategoryModel(id: 0, name: ''),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          gallery: [],
        );
}
