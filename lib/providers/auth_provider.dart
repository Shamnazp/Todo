import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  // Signup
  Future<bool> signup(String email, String password) async {
    try {
      await _service.signup(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      await _service.login(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _service.logout();
  }
}
