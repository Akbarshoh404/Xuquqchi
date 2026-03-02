import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
  });
}

class AuthController extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<bool> signUp({required String email, required String password, required String name}) async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '1', name: name, email: email);
    _setLoading(false);
    return true;
  }

  Future<bool> signIn({required String email, required String password}) async {
    _setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '1', name: 'Andrew Ainsley', email: email);
    _setLoading(false);
    return true;
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
