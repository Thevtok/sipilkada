// ignore_for_file: library_prefixes, avoid_print

import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/difabel.dart';
import 'package:flutter_application_1/models/pendidikan.dart';
import 'package:flutter_application_1/models/profesi.dart';
import 'package:flutter_application_1/models/wilayah.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/agama.dart';
import '../models/api_url.dart';
import '../models/users.dart';
import '../utils/data_user.dart';

class UpdateMarkingService extends GetxController {
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

  @override
  void onInit() {
    super.onInit();

    fetchUserFromSharedPreferences();
    getDifabel();
    getPendidikan();
    getProfesi();
    getRegion();
    getProvinsi();
  }

  final RxList<User> userList = <User>[].obs;
  Future<void> fetchUserFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataJson = prefs.getString('user_data');

      if (userDataJson != null) {
        User user = User.fromJson(jsonDecode(userDataJson));
        userList.add(user);
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  final errorUpdateKonstituen = ''.obs;

  final markId = ''.obs;

  final kkController = TextEditingController();

  final nikController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  final fbController = TextEditingController();

  final igController = TextEditingController();

  final ttController = TextEditingController();

  final xController = TextEditingController();

  final tempatController = TextEditingController();

  final dateController = TextEditingController();

  final addressController = TextEditingController();

  final rtController = TextEditingController();

  final rwController = TextEditingController();

  final ketController = TextEditingController();

  final tpsController = TextEditingController();

  final agamaController = TextEditingController();
  final pendidikanController = TextEditingController();
  final profesiController = TextEditingController();
  final difabelController = TextEditingController();

  final provController = TextEditingController();
  final kabController = TextEditingController();
  final kecController = TextEditingController();
  final kelController = TextEditingController();
  final kelamin = ''.obs;
  final nikah = ''.obs;
  final kategori = ''.obs;

  Future<bool> updateDpt(int id, String? lat, String? long) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      Map<String, dynamic> data = {
        "cakada_id": id,
        "nkk": kkController.text,
        "nik": nikController.text,
        "nama": nameController.text,
        "tempat_lahir": tempatController.text,
        "tanggal_lahir": dateController.text,
        "kawin": nikah.value,
        "jenis_kelamin": kelamin.value,
        "alamat": addressController.text,
        "no_rt": rtController.text,
        "no_rw": rwController.text,
        "difabel": difabelController.text,
        "ket": ketController.text,
        "tps": tpsController.text,
        "sumber_data": null,
        "id_provinsi": provId.value,
        "id_kabupaten": kabId.value,
        "id_kecamatan": kecId.value,
        "id_kelurahan": kelId.value,
        "akun_facebook": fbController.text,
        "akun_instagram": igController.text,
        "akun_twitter": xController.text,
        "akun_tiktok": ttController.text,
        "profesi_id": null,
        "pendidikan_id": pendidikanId.value,
        "agama_id": agamaId.value,
        "difabel_id": difabelId.value,
        "handphone": phoneController.text,
        "email": emailController.text,
        "latitude": lat,
        "longitude": long,
        "mark_id": markId.value,
      };
      print('post data: $data');
      final response = await _dio.post(
        ApiService.updateDptUrl,
        data: data,
      );

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
          errorUpdateKonstituen.value = errorReplcae.replaceAll('"', '');

          return false; // Tambahkan return di sini
        }
        if (responseData != null && responseData['error'] != null) {
          var errorMessages = responseData['error'];
          var errorReplcae = jsonEncode(errorMessages);
          errorUpdateKonstituen.value = errorReplcae.replaceAll('"', '');

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

  final RxList<Religion> religionList = <Religion>[].obs;
  final RxList<DifabelList> difabelList = <DifabelList>[].obs;
  final RxList<Profesi> profesiList = <Profesi>[].obs;
  final RxList<Pendidikan> pendidikanList = <Pendidikan>[].obs;
  final agamaId = 0.obs;
  final difabelId = 0.obs;
  final profesiId = 0.obs;
  final pendidikanId = 5.obs;
  Future<void> getRegion() async {
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
        religionList.addAll(agamaList);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getDifabel() async {
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

        final List<DifabelList> difabel =
            data.map((e) => DifabelList.fromJson(e)).toList();
        difabelList.addAll(difabel);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getPendidikan() async {
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

        final List<Pendidikan> pendidikan =
            data.map((e) => Pendidikan.fromJson(e)).toList();
        pendidikanList.addAll(pendidikan);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  Future<void> getProfesi() async {
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

        final List<Profesi> profesi =
            data.map((e) => Profesi.fromJson(e)).toList();
        profesiList.addAll(profesi);
      }
    } catch (e) {
      print('Error: $e');
      return;
    }
    return;
  }

  RxList<Provinsi> provList = <Provinsi>[].obs;
  RxList<Kabupaten> kabList = <Kabupaten>[].obs;
  RxList<Kecamatan> kecList = <Kecamatan>[].obs;
  RxList<Kelurahan> kelList = <Kelurahan>[].obs;
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
