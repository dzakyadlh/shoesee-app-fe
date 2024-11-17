import 'dart:convert';

import 'package:e_commerce_app/models/cart_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<bool> checkout(
    String token,
    CartModel cart,
    String address,
    double totalPrice,
    double shippingPrice,
  ) async {
    var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var body = jsonEncode({
      'address': address,
      'items': cart.cartProducts
          .map(
            (e) => {
              'id': e.productId,
              'quantity': e.quantity,
            },
          )
          .toList(),
      'status': 'PENDING',
      'total_price': totalPrice,
      'shipping_price': shippingPrice,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      var errorData = jsonDecode(response.body); // Decode the error response
      var errorMessage = errorData['message'] ??
          'Checkout failed'; // Extract error message if available
      throw Exception('Checkout failed: $errorMessage');
    }
  }
}
