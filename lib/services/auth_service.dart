import 'dart:convert';

import 'package:e_commerce_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> register(
      {required String name,
      required String username,
      required String email,
      required String password}) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      var errorData = jsonDecode(response.body); // Decode the error response
      var errorMessage = errorData['message'] ??
          'Register failed'; // Extract error message if available
      throw Exception('Register failed: $errorMessage');
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      var errorData = jsonDecode(response.body); // Decode the error response
      var errorMessage = errorData['message'] ??
          'Login failed'; // Extract error message if available
      throw Exception('Login failed: $errorMessage');
    }
  }
}
