// ignore_for_file: file_names

class ApiService {
  //auth
  static const baseUrl = 'http://103.82.93.59/backend';
  static const loginUrl = '$baseUrl/api/cakada/login';
  static const loginTimsesUrl = '$baseUrl/api/timses/login';
  static const regisUrl = '$baseUrl/api/cakada/register';

  // wilayah
  static const provUrl = '$baseUrl/api/provinsi';
  static const kecUrl = '$baseUrl/api/kab-kota';
  static const kelUrl = '$baseUrl/api/kecamatan';
// profile
  static const regionUrl = '$baseUrl/api/agama';
  static const pendidikanUrl = '$baseUrl/api/pendidikan';
  static const profesiUrl = '$baseUrl/api/profesi';
  static const difabelUrl = '$baseUrl/api/difabel';
// cakada
  static const cakadaUrl = '$baseUrl/api/cakada';

//  DPT
  static const getDptUrl = '$baseUrl/api/dpt?page=';
  static const markDptUrl = '$baseUrl/api/dpt';
   static const updateDptUrl = '$baseUrl/api/dpt/update';

  //kampanye
  static const kampanyeUrl = '$baseUrl/api/campaign';
}
