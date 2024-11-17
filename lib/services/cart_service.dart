import 'dart:convert';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:http/http.dart' as http;

class CartService {
  CartService();
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<CartModel> getCart(String token) async {
    var url = Uri.parse('$baseUrl/cart');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    return _processResponse(response);
  }

  Future<CartModel> updateCartProduct(
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

  Future<CartModel> removeCart(String token) async {
    var url = Uri.parse('$baseUrl/cart');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    var response = await http.delete(url, headers: headers);

    return _processResponse(response);
  }

  CartModel _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return CartModel.fromJson(data);
    } else {
      var errorData = jsonDecode(response.body);
      var errorMessage = errorData['message'];
      throw Exception('Cart operation failed: $errorMessage');
    }
  }
}
