import 'dart:async';

import 'package:ct312h_project/model/user.dart';
import 'package:ct312h_project/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthManager with ChangeNotifier {
  late final AuthService _authService;
  User? _loggedInUser;

  AuthManager() {
    _authService = AuthService(onAuthChange: (User? user) {
      _loggedInUser = user;
      notifyListeners();
    });
  }

  bool get isAuth {
    return _loggedInUser != null;
  }

  User? get user {
    return _loggedInUser;
  }

  Future<User> signup(String username, String email, String password) {
    return _authService.signup(username, email, password);
  }

  Future<User> login(String email, String password) {
    return _authService.login(email, password);
  }

Future<void> tryAutoLogin() async {
    print("Trying auto login...");

    try {
      final user = await _authService.getUserFromStore();
      print("User retrieved: $user");

      if (user != null && _loggedInUser == null) {
        _loggedInUser = user;
        notifyListeners();
      }
    } catch (e) {
      print("Error in tryAutoLogin: $e");
    }
  }




Future<void> logout() async {
    await _authService.logout();
    _loggedInUser = null; // Xóa user khi logout
    notifyListeners(); // Cập nhật UI
  }

}
