// Membuat provider untuk status autentikasi
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final authProvider = StateProvider<bool>((ref) {
//   // Mengambil status autentikasi dari SharedPreferences
//   bool isAuthenticated = false;
//   ref.watch(getAuthStatusProvider).whenData((value) {
//     isAuthenticated = value;
//   });
//   return isAuthenticated;
// });

// // Provider untuk menyimpan status autentikasi ke SharedPreferences
// final setAuthStatusProvider = Provider<Future<bool>>((ref) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final isAuthenticated = ref.watch(authProvider);
//   await sharedPreferences.setBool('isAuthenticated', isAuthenticated);
//   return true;
// });

// // Provider untuk mengambil status autentikasi dari SharedPreferences
// final getAuthStatusProvider = FutureProvider<bool>((ref) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final isAuthenticated = sharedPreferences.getBool('isAuthenticated');
//   return isAuthenticated ?? false;
// });
// Fungsi untuk menyimpan nilai autentikasi ke SharedPreferences
Future<void> saveAuthentication(bool isAuthenticated) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isAuthenticated', isAuthenticated);
}

Future<bool> getAuthentication() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final isAuthenticated = sharedPreferences.getBool('isAuthenticated');
  return isAuthenticated ?? false; // Mengembalikan false jika tidak ada nilai yang tersimpan
}
