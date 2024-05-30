// ignore_for_file: avoid_print, library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/models/demografi.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_url.dart';
import '../models/users.dart';
import '../utils/data_user.dart';

class DemografiService extends GetxController {
 



  final Dio.Dio _dio = Dio.Dio();
  Dio.Options options = Dio.Options(
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
  );
  void setAuthToken(String token) {
    options = Dio.Options(
      headers: {
        'Authorization': token,
        'Accept': 'application/json',
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    fetchUserFromSharedPreferences();
    getDemografi();
  }

  final Rx<Demografi?> progressData = Rx<Demografi?>(null);
  final Rx<User?> userData = Rx<User?>(null);

  final RxBool isLoading = false.obs;
  var idUser = 0.obs;

  Future<void> fetchUserFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString('user_data');
      print(userDataJson);
      if (userDataJson != null) {
        userData.value = User.fromJson(jsonDecode(userDataJson));

        idUser.value = userData.value?.id;
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  Future<Demografi?> getDemografi() async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '${ApiService.cakadaUrl}/${idUser.value}?statistics=1',
        options: options,
      );

      if (response.statusCode == 200) {
        final data = response.data['data']['statistics'];
        print(data);

        progressData.value = Demografi.fromJson(
            data); // Memperbarui progressData dengan data yang diperoleh

        isLoading(
            false); // Setelah berhasil memperbarui progressData, set isLoading menjadi false
        return progressData.value;
      } else {
        isLoading(false);
        print('Failed to fetch progress data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      isLoading(false);
      return null;
    }
  }
}
