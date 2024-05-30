class Konstituen {
  final dynamic id;
  final String? nkk;
  final String? nik;
  final String? nama;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? kawin;
  final String? jenisKelamin;
  final String? alamat;
  final String? noRt;
  final String? noRw;
  final String? difabel;
  final String? ket;
  final String? tps;
  final String? sumberData;
  final dynamic idProvinsi;
  final dynamic namaProvinsi;
  final dynamic idKabupaten;
  final dynamic namaKabupaten;
  final dynamic idKecamatan;
  final dynamic namaKecamatan;
  final dynamic idKelurahan;
  final dynamic namaKelurahan;
  final String? akunFacebook;
  final String? akunInstagram;
  final String? akunTwitter;
  final String? akunTiktok;
  final int? profesiId;
  final String? profesiName;
  final int? pendidikanId;
  final String? pendidikanName;
  final int? agamaId;
  final String? agamaName;
  final int? difabelId;
  final String? difabelName;
  final String? foto;
  final String? fotoKtp;
  final String? handphone;
  final String? email;
  final String? latitude;
  final String? longitude;
  final int? markId;
  final String? markName;
  final int? inputById;
  final String? inputByName;
  final String? inputByRole;
  final String? inputByTime;

  Konstituen({
    this.id,
    this.nkk,
    this.nik,
    this.nama,
    this.tempatLahir,
    this.tanggalLahir,
    this.kawin,
    this.jenisKelamin,
    this.alamat,
    this.noRt,
    this.noRw,
    this.difabel,
    this.ket,
    this.tps,
    this.sumberData,
    this.idProvinsi,
    this.namaProvinsi,
    this.idKabupaten,
    this.namaKabupaten,
    this.idKecamatan,
    this.namaKecamatan,
    this.idKelurahan,
    this.namaKelurahan,
    this.akunFacebook,
    this.akunInstagram,
    this.akunTwitter,
    this.akunTiktok,
    this.profesiId,
    this.profesiName,
    this.pendidikanId,
    this.pendidikanName,
    this.agamaId,
    this.agamaName,
    this.difabelId,
    this.difabelName,
    this.foto,
    this.fotoKtp,
    this.handphone,
    this.email,
    this.latitude,
    this.longitude,
    this.markId,
    this.markName,
    this.inputById,
    this.inputByName,
    this.inputByRole,
    this.inputByTime,
  });

  factory Konstituen.fromJson(Map<String, dynamic> json) {
    return Konstituen(
      id: json['id'],
      nkk: json['nkk'],
      nik: json['nik'],
      nama: json['nama'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'],
      kawin: json['kawin'],
      jenisKelamin: json['jenis_kelamin'],
      alamat: json['alamat'],
      noRt: json['no_rt'],
      noRw: json['no_rw'],
      difabel: json['difabel'],
      ket: json['ket'],
      tps: json['tps'],
      sumberData: json['sumber_data'],
      idProvinsi: json['id_provinsi'],
      namaProvinsi: json['nama_provinsi'],
      idKabupaten: json['id_kabupaten'],
      namaKabupaten: json['nama_kabupaten'],
      idKecamatan: json['id_kecamatan'],
      namaKecamatan: json['nama_kecamatan'],
      idKelurahan: json['id_kelurahan'],
      namaKelurahan: json['nama_kelurahan'],
      akunFacebook: json['akun_facebook'],
      akunInstagram: json['akun_instagram'],
      akunTwitter: json['akun_twitter'],
      akunTiktok: json['akun_tiktok'],
      profesiId: json['profesi_id'],
      profesiName: json['profesi_name'],
      pendidikanId: json['pendidikan_id'],
      pendidikanName: json['pendidikan_name'],
      agamaId: json['agama_id'],
      agamaName: json['agama_name'],
      difabelId: json['difabel_id'],
      difabelName: json['difabel_name'],
      foto: json['foto'],
      fotoKtp: json['foto_ktp'],
      handphone: json['handphone'],
      email: json['email'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      markId: json['mark_id'],
      markName: json['mark_name'],
      inputById: json['input_by_id'],
      inputByName: json['input_by_name'],
      inputByRole: json['input_by_role'],
      inputByTime: json['input_by_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nkk': nkk,
      'nik': nik,
      'nama': nama,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'kawin': kawin,
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
      'no_rt': noRt,
      'no_rw': noRw,
      'difabel': difabel,
      'ket': ket,
      'tps': tps,
      'sumber_data': sumberData,
      'id_provinsi': idProvinsi,
      'nama_provinsi': namaProvinsi,
      'id_kabupaten': idKabupaten,
      'nama_kabupaten': namaKabupaten,
      'id_kecamatan': idKecamatan,
      'nama_kecamatan': namaKecamatan,
      'id_kelurahan': idKelurahan,
      'nama_kelurahan': namaKelurahan,
      'akun_facebook': akunFacebook,
      'akun_instagram': akunInstagram,
      'akun_twitter': akunTwitter,
      'akun_tiktok': akunTiktok,
      'profesi_id': profesiId,
      'profesi_name': profesiName,
      'pendidikan_id': pendidikanId,
      'pendidikan_name': pendidikanName,
      'agama_id': agamaId,
      'agama_name': agamaName,
      'difabel_id': difabelId,
      'difabel_name': difabelName,
      'foto': foto,
      'foto_ktp': fotoKtp,
      'handphone': handphone,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'mark_id': markId,
      'mark_name': markName,
      'input_by_id': inputById,
      'input_by_name': inputByName,
      'input_by_role': inputByRole,
      'input_by_time': inputByTime,
    };
  }
}
