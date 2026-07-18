import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  String _errorMessage = "";

  String _userRole = "";

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  String get userRole => _userRole;

  User? get currentUser => _authService.currentUser;

  //==========================================
  // LOGIN
  //==========================================

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = "";

      notifyListeners();

      await _authService.login(
        email: email,
        password: password,
      );

      final document =
          await _authService.getCurrentUserDocument();

      if (!document.exists) {
        _errorMessage = "User record not found.";

        _isLoading = false;

        notifyListeners();

        return false;
      }

      final data = document.data();

      _userRole = data?["role"] ?? "";

      _isLoading = false;

      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          _errorMessage = "No account found.";

          break;

        case "wrong-password":
          _errorMessage = "Incorrect password.";

          break;

        case "invalid-credential":
          _errorMessage = "Invalid email or password.";

          break;

        case "invalid-email":
          _errorMessage = "Invalid email address.";

          break;

        default:
          _errorMessage = e.message ?? "Login failed.";
      }

      _isLoading = false;

      notifyListeners();

      return false;
    } catch (e) {
      _errorMessage = e.toString();

      _isLoading = false;

      notifyListeners();

      return false;
    }
  }

  //==========================================
  // LOGOUT
  //==========================================

  Future<void> logout() async {
    await _authService.logout();

    _userRole = "";

    notifyListeners();
  }

  //==========================================
  // RESET PASSWORD
  //==========================================

  Future<void> resetPassword(
    String email,
  ) async {
    await _authService.sendResetEmail(
      email,
    );
  }
}