import 'dart:convert';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/products');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      var errorData = jsonDecode(response.body); // Decode the error response
      var errorMessage = errorData['message'] ??
          'Fetch products data failed'; // Extract error message if available
      throw Exception('Fetch products failed: $errorMessage');
    }
  }
}
