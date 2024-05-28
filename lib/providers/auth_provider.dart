import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';

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
}
