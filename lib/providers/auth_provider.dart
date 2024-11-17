import 'dart:convert';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  // Initial state is an empty user wrapped in AsyncValue
  @override
  Future<UserModel> build() async {
    return await loadUserSession();
  }

  // Register user
  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      await _saveUserSession(user);
      state = AsyncValue.data(user); // Set state as AsyncValue
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error during registration: $e');
      state = AsyncValue.error(e, stackTrace); // Set state as error
      return false;
    }
  }

  // Login user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      await _saveUserSession(user);
      state = AsyncValue.data(user); // Set state as AsyncValue
      return true;
    } catch (e, stackTrace) {
      debugPrint('Error during login: $e');
      state = AsyncValue.error(e, stackTrace); // Set state as error
      return false;
    }
  }

  // Load user session from shared preferences
  Future<UserModel> loadUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userData = preferences.getString('userData');
    String? token = preferences.getString('userToken');

    if (userData != null && token != null) {
      Map<String, dynamic> json = jsonDecode(userData);
      UserModel user = UserModel.fromJson(json);
      user.token = token;
      return user;
    } else {
      return UserModel(id: 0, name: '', email: '', username: '');
    }
  }

  // Save user session to shared preferences
  Future<void> _saveUserSession(UserModel user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userData = jsonEncode(user.toJson());
    await preferences.setString('userData', userData);
    await preferences.setString('userToken', user.token ?? '');
  }

  // Logout user
  Future<void> logout() async {
    state =
        AsyncValue.data(UserModel(id: 0, name: '', email: '', username: ''));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userToken');
    await preferences.remove('userData');
  }
}
