// ignore_for_file: library_prefixes, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/api_url.dart';
import '../models/konstituen.dart';
import '../models/wilayah.dart';
import '../utils/data_user.dart';

class SearchService extends GetxController {


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

  final RxList<Konstituen> konstituenListSearch = <Konstituen>[].obs;
  final RxBool isLoading = false.obs;

  var nameController = TextEditingController();
  var nikController = TextEditingController();

  var provController = TextEditingController();
  var kabController = TextEditingController();
  var kecController = TextEditingController();
  var kelController = TextEditingController();

  final kategori = ''.obs;
  final markId = ''.obs;
  final kelamin = 'L'.obs;

  @override
  void onInit() {
    super.onInit();
  
    getProvinsi();
  }

  final errorSearch = ''.obs;

  Future<void> getDptSearch(nik, kelamin, prov, kab, kec, kel, nama) async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');

      final response = await _dio.get(
        '${ApiService.markDptUrl}?nik=$nik&jenis_kelamin=$kelamin&provinsi=$prov&kabupaten=$kab&kecamatan=$kec&kelurahan=$kel&nama=$nama',
        options: options,
      );
      print(response.data);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['data'];

        // Tambahkan data konstituen dari halaman saat ini ke dalam _konstituenList
        final List<Konstituen> currentPageKonstituenList =
            data.map((e) => Konstituen.fromJson(e)).toList();
        konstituenListSearch.addAll(currentPageKonstituenList);
        isLoading(false);
        nameController.clear();
        nikController.clear();
        provController.clear();
        kabController.clear();
        kecController.clear();
        kelController.clear();
      }
    } on Dio.DioException catch (e) {
      if (e.response != null) {
        Map<String, dynamic>? responseData = e.response?.data;
        print(responseData);

        if (responseData != null && responseData['message'] != null) {
          var errorMessages = responseData['message'].replaceAll('"', '');
          errorSearch.value = jsonEncode(errorMessages);
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'].replaceAll('"', '');
          errorSearch.value = jsonEncode(errorMessages);
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
}
