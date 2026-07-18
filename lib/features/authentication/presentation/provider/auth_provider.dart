import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? get currentUser => _authService.currentUser;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.login(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw _getReadableMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.register(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      throw _getReadableMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }
  Future<String> getInitialRoute() async {

  if (currentUser == null) {
    return "/login";
  }

  final document =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get();

  if (!document.exists) {
    return "/login";
  }

  final role =
      document.data()?["role"] ?? "";

  switch (role) {

    case "admin":
      return "/admin/dashboard";

    case "lecturer":
      return "/lecturer/dashboard";

    case "student":
      return "/student/dashboard";

    default:
      return "/login";
  }
}

  String _getReadableMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
        return 'Incorrect password.';

      case 'invalid-credential':
        return 'Invalid email or password.';

      case 'email-already-in-use':
        return 'Email already exists.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'network-request-failed':
        return 'No internet connection.';

      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}