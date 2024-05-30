// ignore_for_file: non_constant_identifier_names

class User {
  dynamic id;
  final String? name;
  String? username;
  String? nik;
  String? tmpt_lahir;
  String? tgl_lahir;
  String? gender;
  String? address;
  final String? email;
  final String password;
  final String phone;
  dynamic idProvinsi;
 dynamic idKabKota;
  int? idKecamatan;
  int? idKelurahan;
  String? keterangan;
  double? lastLat;
  double? lastLng;
  String? device_model;
  String? device_id;
  final String app_version;
  String? fcm_token;
  final int level;
  String? subscription;
  String? level_name;
  String? name_provinsi;
  dynamic name_kab_kota;
  String? avatar;

  User(
      {this.id,
      required this.name,
      required this.username,
      this.nik,
      this.tmpt_lahir,
      this.tgl_lahir,
      this.gender,
      this.address,
      required this.email,
      required this.password,
      required this.phone,
      required this.idProvinsi,
      this.idKabKota,
      this.idKecamatan,
      this.idKelurahan,
      this.keterangan,
      this.lastLat,
      this.lastLng,
      this.device_model,
      this.device_id,
      required this.app_version,
      this.fcm_token,
      this.subscription,
      required this.level,
      this.level_name,
      this.name_kab_kota,
      this.name_provinsi,
      this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      nik: json['nik'] ?? '',
      tmpt_lahir: json['tmpt_lahir'] ?? '',
      tgl_lahir: json['tgl_lahir'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      idProvinsi: json['id_provinsi'] ?? 0,
      idKabKota: json['id_kab_kota'] ?? 0,
      idKecamatan: json['id_kecamatan'] ?? 0,
      idKelurahan: json['id_desa_kel'] ?? 0,
      device_model: json['device_model'] ?? '',
      device_id: json['device_id'] ?? '',
      lastLat: json['last_lat'] ?? 0,
      lastLng: json['last_lng'] ?? 0,
      app_version: json['app_version'] ?? '',
      fcm_token: json['fcm_token'] ?? '',
      level: json['level'] ?? 0,
      subscription: json['subscription'] ?? '',
      level_name: json['level_name'] ?? '',
      name_provinsi: json['name_provinsi'] ?? '',
      name_kab_kota: json['name_kab_kota'] ?? '',
      avatar: json['avatar'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'nik': nik,
      'tmpt_lahir': tmpt_lahir,
      'tgl_lahir': tgl_lahir,
      'gender': gender,
      'address': address,
      'email': email,
      'password': password,
      'phone': phone,
      'id_provinsi': idProvinsi,
      'id_kab_kota': idKabKota,
      'id_kecamatan': idKecamatan,
      'id_desa_kel': idKelurahan,
      'device_model': device_model,
      'device_id': device_id,
      'last_lat': lastLat,
      'last_lng': lastLng,
      'app_version': app_version,
      'fcm_token': fcm_token,
      'level': level
    };
  }
}
