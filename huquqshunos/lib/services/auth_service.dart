// lib/services/auth_service.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLawyer => _currentUser?.role == UserRole.lawyer;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Simulate login (replace with Firebase)
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    // Demo login
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = UserModel(
        id: 'demo_user',
        fullName: 'Demo Foydalanuvchi',
        email: email,
        phone: '+998901234567',
        role: email.contains('lawyer') ? UserRole.lawyer : UserRole.client,
        createdAt: DateTime.now(),
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _error = 'Noto\'g\'ri email yoki parol';
    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Simulate register
  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required UserRole role,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email,
      phone: phone,
      role: role,
      createdAt: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
