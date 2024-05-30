import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserToSharedPreferences(Map<String, dynamic> userData) async {
  final prefs = await SharedPreferences.getInstance();
  final userDataJson = jsonEncode(userData);
  await prefs.setString('user_data', userDataJson);
}

Future<Map<String, dynamic>?> getUserFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataJson = prefs.getString('user_data');
  if (userDataJson != null) {
    return jsonDecode(userDataJson);
  } else {
    return null;
  }
}

Future<void> removeUserFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_data');
}



Future<void> saveTokenToSharedPreferences(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}


// Fungsi untuk mendapatkan token dari SharedPreferences
Future<String?> getTokenFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}