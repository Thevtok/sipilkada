// ignore_for_file: library_prefixes, avoid_print, depend_on_referenced_packages, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

import '../models/api_url.dart';
import '../models/wilayah.dart';
import '../utils/data_user.dart';

class AuthService extends GetxController {
  
 

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

    getProvinsi();
  }


var kabList = <Kabupaten>[].obs;
final RxList<Provinsi> provLsit = <Provinsi>[].obs;

final RxBool isLoading = false.obs;

var idProv = 0.obs;
var idKab = 0.obs;

final nameController = TextEditingController();
final phoneController = TextEditingController();
final emailController = TextEditingController();
final passController = TextEditingController();
final provController = TextEditingController();
final kabController = TextEditingController();


  

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiService.loginUrl,
        options: options,
        data: {
          'email': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        var token = response.data['data']['access_token'];
        var user = response.data['data']['user'];
        await saveUserToSharedPreferences(user);
        await saveTokenToSharedPreferences(token);
        return null;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        } else {
          return 'Error: Something is wrong';
        }
      } else {
        print('Error: ${e.message}');
        return 'An error occurred';
      }
    }
    return null;
  }

  Future<String?> loginTimses(String username, String password) async {
    try {
      final response = await _dio.post(
       ApiService.loginTimsesUrl,
        options: options,
        data: {
          'email': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        var token = response.data['data']['access_token'];
        var user = response.data['data']['user'];
        await saveUserToSharedPreferences(user);
        await saveTokenToSharedPreferences(token);
        return null;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        } else {
          return 'Error: Something is wrong';
        }
      } else {
        print('Error: ${e.message}');
        return 'An error occurred';
      }
    }
    return null;
  }

  Future<String?> register(User user) async {
    try {
      final response =
          await _dio.post(ApiService.regisUrl, options: options, data: user.toJson());

      if (response.statusCode == 200) {
        var token = response.data['data']['access_token'];
        var user = response.data['data']['user'];

        await saveUserToSharedPreferences(user);
        await saveTokenToSharedPreferences(token);
        return null;
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorMessage = jsonEncode(errorMessages).replaceAll('"', '');
          return errorMessage;
        } else {
          return 'Error: Something is wrong';
        }
      } else {
        print('Error: ${e.message}');
        return 'An error occurred';
      }
    }
    return null;
  }

  Future<void> getKabupaten(int id) async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '${ApiService.provUrl}/$id',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['kab_kota'];
        print(data);

        final List<Kabupaten> kab =
            data.map((e) => Kabupaten.fromJson(e)).toList();
        kabList.addAll(kab);
      }
    } catch (e) {
      isLoading(false);
      print('Error: $e');
      return;
    }
    isLoading(false);
    return;
  }
   Future<void> getProvinsi() async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.provUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Provinsi> kab =
            data.map((e) => Provinsi.fromJson(e)).toList();
        provLsit.addAll(kab);
      }
    } catch (e) {
      isLoading(false);
      print('Error: $e');
      return;
    }
    isLoading(false);
    return;
  }
}
