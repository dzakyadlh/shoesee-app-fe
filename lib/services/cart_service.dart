import 'dart:convert';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:http/http.dart' as http;

class CartService {
  CartService();
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<CartProduct>> getCart(String token) async {
    var url = Uri.parse('$baseUrl/cart');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    return _processResponse(response);
  }

  Future<List<CartProduct>> updateCartProduct(
      String token, int productId, int quantity) async {
    var url = Uri.parse('$baseUrl/cart');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
      'product_id': productId,
      'quantity': quantity,
    });

    var response = await http.post(url, headers: headers, body: body);

    return _processResponse(response);
  }

  Future<List<CartProduct>> removeCartProduct(
      String token, int productId) async {
    var url = Uri.parse('$baseUrl/cart/$productId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await http.delete(url, headers: headers);

    return _processResponse(response);
  }

  List<CartProduct> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['data']['cart_products'];
    } else {
      var errorData = jsonDecode(response.body);
      var errorMessage = errorData['message'] ?? 'Remove cart failed';
      throw Exception('Remove cart failed: $errorMessage');
    }
  }
}
