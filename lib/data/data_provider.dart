

// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



final userProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final userDataJson = prefs.getString('user_data');
  if (userDataJson != null) {
    return jsonDecode(userDataJson);
  } else {
    return null;
  }
});