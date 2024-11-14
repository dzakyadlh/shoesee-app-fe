import 'dart:convert';

import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = UserModel(id: 0, name: '', email: '', username: '');

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
          name: name, username: username, email: email, password: password);

      _user = user;

      return true;
    } catch (e) {
      debugPrint('Error during registration: $e');
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);

      _user = user;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userData = jsonEncode(
          user.toJson()); // Converts the user data to a proper JSON string
      await preferences.setString('userData', userData);
      await preferences.setString('userToken', user.token ?? '');

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  Future<void> loadUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('userToken');
    String? userData = preferences.getString('userData');

    if (token != null && userData != null) {
      Map<String, dynamic> json = jsonDecode(userData);
      UserModel user = UserModel.fromJson(json);
      user.token = token;

      _user = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = UserModel(id: 0, name: '', email: '', username: '');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userToken');
    await preferences.remove('userData');
    notifyListeners();
  }
}
