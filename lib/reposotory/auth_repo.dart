import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = true;
  String? _userEmail;

  final Box _authBox = Hive.box('auth');

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userEmail => _userEmail;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    await _authBox.put('isAuthenticated', true);
    await _authBox.put('userEmail', email);

    _isAuthenticated = true;
    _userEmail = email;
    _isLoading = false;
    notifyListeners();
  }
  Future<void> signup(String email, String password) async {
    await login(email, password);
  }
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authBox.clear();

    _isAuthenticated = false;
    _userEmail = null;
    _isLoading = false;
    notifyListeners();
  }
  Future<void> tryAutoLogin() async {
    _isAuthenticated = _authBox.get('isAuthenticated', defaultValue: false);
    if (_isAuthenticated) {
      _userEmail = _authBox.get('userEmail');
    }

    _isLoading = false;
    notifyListeners();
  }
}

