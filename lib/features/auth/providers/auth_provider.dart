import 'package:flutter/material.dart';

import '../../../core/services/firebase_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String _displayName = 'Laila';

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String get displayName => _displayName;

  Future<void> signIn({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    final firebaseLoginSucceeded = await FirebaseService.signInWithEmailPassword(
      email: email,
      password: password,
    );

    if (firebaseLoginSucceeded) {
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 500));

    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register({required String name, required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    final firebaseRegisterSucceeded = await FirebaseService.registerWithEmailPassword(
      email: email,
      password: password,
      name: name,
    );

    if (firebaseRegisterSucceeded) {
      _displayName = name.isNotEmpty ? name : 'Laila';
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 600));

    _displayName = name.isNotEmpty ? name : 'Laila';
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await FirebaseService.signOut();
    _isAuthenticated = false;
    notifyListeners();
  }
}
