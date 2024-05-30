// ignore_for_file: library_prefixes, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/api_url.dart';
import 'package:flutter_application_1/models/kampanye.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users.dart';
import '../models/wilayah.dart';
import '../utils/data_user.dart';

class KampanyeService extends GetxController {
  final Dio.Dio _dio = Dio.Dio();
  Dio.Options options = Dio.Options(
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
  );
  void setAuthToken(String token) {
    options = Dio.Options(
      headers: {
        'Authorization': token,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
  }

  final RxBool isLoading = false.obs;

  var titileController = TextEditingController();
  var subTitileController = TextEditingController();
  var budgetController = TextEditingController();
  var jamController = TextEditingController();
  var dateController = TextEditingController();
  var addressContoler = TextEditingController();

  var provController = TextEditingController();
  var kabController = TextEditingController();
  var kecController = TextEditingController();
  var kelController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    fetchUserFromSharedPreferences();
    getProvinsi();
    getKampanye();
  }

  var idUser = 0.obs;
  final Rx<User?> userData = Rx<User?>(null);
  final RxList<Campaign> campaignList = <Campaign>[].obs;

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

  final RxList<Provinsi> provList = <Provinsi>[].obs;
  RxList<Kabupaten> kabList = <Kabupaten>[].obs;
  RxList<Kecamatan> kecList = <Kecamatan>[].obs;
  final RxList<Kelurahan> kelList = <Kelurahan>[].obs;
  final provId = 0.obs;
  final kabId = 0.obs;
  final kecId = 0.obs;
  final kelId = 0.obs;

  Future<void> getProvinsi() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        ApiService.provUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Provinsi> prov =
            data.map((e) => Provinsi.fromJson(e)).toList();
        provList.addAll(prov);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getKabupaten(int id) async {
    try {
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
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getKecamatan(int id) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '${ApiService.kecUrl}/$id}',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['kecamatan'];
        print(data);

        final List<Kecamatan> kec =
            data.map((e) => Kecamatan.fromJson(e)).toList();
        kecList.addAll(kec);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getKelurahan(int id) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '${ApiService.kelUrl}/$id',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['desa_kel'];
        print(data);

        final List<Kelurahan> kel =
            data.map((e) => Kelurahan.fromJson(e)).toList();
        kelList.addAll(kel);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  var errorKonstituen = ''.obs;

  Future<bool> addKampanye() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      Map<String, dynamic> data = {
        "id_cakada": idUser.value,
        "name": titileController.text,
        "description": subTitileController.text,
        "date": dateController.text, // YYYY-MMD
        "clock": jamController.text, // HH:mm
        "nama_provinsi": provController.text,
        "nama_kabupaten": kabController.text,
        "nama_kecamatan": kecController.text,
        "nama_kelurahan": kelController.text,
        "address": addressContoler.text,
        "budget": budgetController.text
      };
      print('post data: $data');
      final response =
          await _dio.post(ApiService.kampanyeUrl, data: data, options: options);

      print(response.data);

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
          var errorReplcae = jsonEncode(errorMessages);
          errorKonstituen.value = errorReplcae.replaceAll('"', '');

          return false; // Tambahkan return di sini
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorReplcae = jsonEncode(errorMessages);
          errorKonstituen.value = errorReplcae.replaceAll('"', '');

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

  var errorMarking = ''.obs;
  Future<void> getKampanye() async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');

      final response = await _dio.get(
        '${ApiService.kampanyeUrl}?id_cakada=${idUser.value}',
        options: options,
      );
      print(response.data);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        // Tambahkan data konstituen dari halaman saat ini ke dalam _konstituenList
        final List<Campaign> currentPageCampaignList =
            data.map((e) => Campaign.fromJson(e)).toList();
        campaignList.addAll(currentPageCampaignList);
        isLoading(false);
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'];
          errorMarking.value = jsonEncode(errorMessages);
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          errorMarking.value = jsonEncode(errorMessages);
        } else {}
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('Error: $e');
      return;
    } finally {
      isLoading(false);
    }
    return;
  }
}
