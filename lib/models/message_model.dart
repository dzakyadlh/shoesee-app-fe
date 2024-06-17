import 'package:e_commerce_app/models/product_model.dart';

class MessageModel {
  String message;
  int userId;
  String username;
  String userImageUrl;
  bool isFromUser;
  ProductModel product;
  DateTime createdAt;
  DateTime updatedAt;

  MessageModel({
    required this.message,
    required this.userId,
    required this.username,
    required this.userImageUrl,
    required this.isFromUser,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        userId = json['userId'],
        username = json['username'],
        userImageUrl = json['userImageUrl'],
        isFromUser = json['isFromUser'],
        product = json['product'].isEmpty
            ? UninitializedProductModel()
            : ProductModel.fromJson(json['product']),
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'username': username,
      'userImageUrl': userImageUrl,
      'isFromUser': isFromUser,
      'product': product is UninitializedProductModel ? {} : product.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
