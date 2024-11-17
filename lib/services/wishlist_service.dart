import 'dart:convert';
import 'package:e_commerce_app/models/wishlist_model.dart';
import 'package:http/http.dart' as http;

class WishlistService {
  WishlistService();
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<WishlistModel> getWishlists(String token) async {
    var url = Uri.parse('$baseUrl/wishlist');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    return _processResponse(response);
  }

  Future<WishlistModel> addWishlist(String token, int productId) async {
    var url = Uri.parse('$baseUrl/wishlist/$productId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(url, headers: headers);

    return _processResponse(response);
  }

  Future<WishlistModel> removeWishlist(String token, int productId) async {
    var url = Uri.parse('$baseUrl/wishlist/$productId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.delete(url, headers: headers);

    return _processResponse(response);
  }

  WishlistModel _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return WishlistModel.fromJson(data);
    } else {
      var errorData = jsonDecode(response.body);
      var errorMessage = errorData['message'];
      throw Exception('Wishlist operation failed: $errorMessage');
    }
  }
}
