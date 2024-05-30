// ignore_for_file: library_prefixes, avoid_print, depend_on_referenced_packages, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/models/agama.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_application_1/models/difabel.dart';
import 'package:flutter_application_1/models/pendidikan.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_url.dart';
import '../models/profesi.dart';
import '../models/users.dart';
import '../utils/data_user.dart';

class ProfileService extends GetxController {
  static const baseUrl = 'http://103.82.93.59/backend';

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
  //   @override
  // void onInit() {
  //   super.onInit();
  //  fetchUserFromSharedPreferences();
  //  getCakada();
  // }

  var fotoProfile = Rx<File?>(null);

  final RxBool isLoading = false.obs;
  var errorFoto = ''.obs;
  var idUser = 0.obs;

  final Rx<User?> userData = Rx<User?>(null);
  Future<void> fetchUserFromSharedPreferences() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString('user_data');

      if (userDataJson != null) {
        userData.value = User.fromJson(jsonDecode(userDataJson));
        idUser.value = userData.value?.id;
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print('Error retrieving user data: $e');
    }
  }

  Future<List<Religion>?> getRegion() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.regionUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Religion> agamaList =
            data.map((e) => Religion.fromJson(e)).toList();

        return agamaList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<List<DifabelList>?> getDifabel() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.difabelUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<DifabelList> difabelList =
            data.map((e) => DifabelList.fromJson(e)).toList();

        return difabelList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<List<Pendidikan>?> getPendidikan() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.pendidikanUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Pendidikan> pendidikanList =
            data.map((e) => Pendidikan.fromJson(e)).toList();

        return pendidikanList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<List<Profesi>?> getProfesi() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.profesiUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Profesi> profesiList =
            data.map((e) => Profesi.fromJson(e)).toList();

        return profesiList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  Future<bool> addFoto() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');

      final formData = Dio.FormData.fromMap({'avatar': fotoProfile.value});

      final response = await _dio.post(
        '${ApiService.cakadaUrl}/${idUser.value}/avatar',
        data: formData,
        options: options,
      );

      if (response.statusCode == 200) {
        // Berhasil menandai data
        return true;
      } else {
        // Gagal menandai data
        return false;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'];
          var errorReplace = jsonEncode(errorMessages);
          errorFoto.value = errorReplace.replaceAll('"', '');

          return false; // Tambahkan return di sini
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorReplace = jsonEncode(errorMessages);
          errorFoto.value = errorReplace.replaceAll('"', '');

          return false; // Tambahkan return di sini
        } else {
          return false;
        }
      } else {
        print('Error: ${e.message}');
        return false;
      }
    } catch (e) {
      print('Error marking data: $e');
      return false;
    }
  }

  Future<User?> getCakada() async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '${ApiService.cakadaUrl}/${idUser.value}',
        options: options,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        print(data);

        userData.value = User.fromJson(
            data); // Memperbarui progressData dengan data yang diperoleh

        isLoading(
            false); // Setelah berhasil memperbarui progressData, set isLoading menjadi false
        return userData.value;
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
