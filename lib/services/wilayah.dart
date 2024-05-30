
// ignore_for_file: avoid_print, library_prefixes

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_application_1/models/wilayah.dart';

import '../utils/data_user.dart';
class WilayahService {
  static const baseUrl = 'http://103.82.93.59/backend';
  static const provUrl = '$baseUrl/api/provinsi';
  static const kecUrl = '$baseUrl/api/kab-kota';
  static const kelUrl = '$baseUrl/api/kecamatan';


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

 

   Future<List<Provinsi>?> getProvinsi() async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        provUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print(data);

        final List<Provinsi> provList =
            data.map((e) => Provinsi.fromJson(e)).toList();

        return provList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

   Future<List<Kabupaten>?> getKabupaten(int idProv) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '$provUrl/$idProv',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['kab_kota'];
        print(data);

        final List<Kabupaten> kabList =
            data.map((e) => Kabupaten.fromJson(e)).toList();

        return kabList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }
  Future<List<Kecamatan>?> getKecamatan(int idKab) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '$kecUrl/$idKab',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['kecamatan'];
        print(data);

        final List<Kecamatan> kecList =
            data.map((e) => Kecamatan.fromJson(e)).toList();

        return kecList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }
  Future<List<Kelurahan>?> getKelurahan(int idKec) async {
    try {
      final token = await getTokenFromSharedPreferences();
      setAuthToken(token ?? '');
      final response = await _dio.get(
        '$kelUrl/$idKec',
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['desa_kel'];
        print(data);

        final List<Kelurahan> kelList =
            data.map((e) => Kelurahan.fromJson(e)).toList();

        return kelList;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }
}
