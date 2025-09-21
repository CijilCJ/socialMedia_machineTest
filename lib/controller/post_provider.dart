import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final Box userBox = Hive.box('userBox');
  String? currentEmail;

  Future<bool> signUp(String username, String email, String password) async {
    // avoid duplicate email
    final exists = userBox.values.any((u) => u['email'] == email);
    if (exists) return false;

    userBox.add({
      'username': username,
      'email': email,
      'password': password,
    });
    return true;
  }

  Future<bool> login(String email, String password) async {
    final user = userBox.values.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );
    if (user == null) return false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
    currentEmail = email;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('email');
    currentEmail = null;
    notifyListeners();
  }

  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (loggedIn) {
      currentEmail = prefs.getString('email');
    } else {
      currentEmail = null;
    }
    notifyListeners();
  }

  Map<String, dynamic>? getCurrentUser() {
  if (currentEmail == null) return null;

  try {
    return userBox.values
        .cast<Map<String, dynamic>>()
        .firstWhere((u) => u['email'] == currentEmail);
  } catch (e) {
    return null;
  }
}

}
