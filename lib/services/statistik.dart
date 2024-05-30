// ignore_for_file: avoid_print, library_prefixes

import 'dart:convert';

import 'package:flutter_application_1/models/statistik.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_url.dart';
import '../models/users.dart';
import '../utils/data_user.dart';

class StatistikService extends GetxController {


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
    getProgress();
   
    getProgressWilayah();
  }

  final Rx<StatistikProgress?> progressData = Rx<StatistikProgress?>(null);
  final Rx<User?> userData = Rx<User?>(null);
  final RxList<WilayahData> progresList = <WilayahData>[].obs;

  final RxBool isLoading = false.obs;
  var idUser = 0.obs;
  int currentPage = 8;

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

  Future<StatistikProgress?> getProgress() async {
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

        progressData.value = StatistikProgress.fromJson(
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

 Future<void> getProgressWilayah() async {
    try {
      isLoading(true);
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');

      final response = await _dio.get(
        '${ApiService.cakadaUrl}/${idUser.value}?details=1&per_page=1000',
        options: options,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data']['details']['data']
            .where((entry) =>
                entry['nama_kabupaten'] != null &&
                entry['nama_kecamatan'] == null &&
                entry['nama_kelurahan'] == null)
            .toList();
        print('ikeh $data');
        print('Panjang data: ${data.length}');

        // Tambahkan data konstituen dari halaman saat ini ke dalam _konstituenList
        final List<WilayahData> currentPageWilayahDataList =
            data.map((e) => WilayahData.fromJson(e)).toList();
        progresList.addAll(currentPageWilayahDataList);
        isLoading(false);
      }
    } catch (e) {
      print('Error: $e');
      isLoading(false);
    }
  }

 
}
