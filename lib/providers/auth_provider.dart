import 'dart:convert';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  // Initial state is AsyncLoading to indicate loading status
  @override
  AsyncValue<UserModel> build() {
    return const AsyncLoading();
  }

  // Register user
  Future<AsyncValue<UserModel>> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // Call the register method and return AsyncData with the user model on success
      UserModel user = await AuthService().register(
          name: name, username: username, email: email, password: password);
      return AsyncData(user);
    } catch (e, stackTrace) {
      // Return AsyncError if there is an error
      debugPrint('Error during registration: $e');
      return AsyncError(e.toString(), stackTrace);
    }
  }

  // Login user
  Future<AsyncValue<UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Show loading state while the login process is happening
      state = const AsyncLoading();

      // Perform login
      UserModel user =
          await AuthService().login(email: email, password: password);

      // Save user to shared preferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userData = jsonEncode(user.toJson());
      await preferences.setString('userData', userData);
      await preferences.setString('userToken', user.token ?? '');

      // Return AsyncData if login is successful
      return AsyncData(user);
    } catch (e, stackTrace) {
      // Return AsyncError in case of failure
      debugPrint('Error during login: $e');
      return AsyncError(e.toString(), stackTrace);
    }
  }

  // Load user session from shared preferences
  Future<void> loadUserSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('userToken');
    String? userData = preferences.getString('userData');

    if (token != null && userData != null) {
      Map<String, dynamic> json = jsonDecode(userData);
      UserModel user = UserModel.fromJson(json);
      user.token = token;

      state = AsyncData(user);
    } else {
      state = AsyncData(UserModel(id: 0, name: '', email: '', username: ''));
    }
  }

  // Logout user
  Future<void> logout() async {
    state = AsyncData(UserModel(id: 0, name: '', email: '', username: ''));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userToken');
    await preferences.remove('userData');
  }
}
