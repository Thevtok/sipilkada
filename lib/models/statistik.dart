// ignore_for_file: non_constant_identifier_names

class StatistikProgress {
  final dynamic targetSuara;
  final dynamic grandTotal;
  final dynamic totalKonstituen;

  final dynamic potensiTinggi;
  final dynamic potensiSedang;
  final dynamic potensiRendah;
  final dynamic total_tps;
  final dynamic total_tps_male;
  final dynamic total_tps_female;
  final dynamic total_kab_kota;
  final dynamic total_kecamatan;
  final dynamic total_desa_kel;

  StatistikProgress(
      {required this.targetSuara,
      required this.grandTotal,
      required this.totalKonstituen,
      required this.potensiTinggi,
      required this.potensiSedang,
      required this.potensiRendah,
      required this.total_tps,
      required this.total_tps_male,
      required this.total_tps_female,
      required this.total_kab_kota,
      required this.total_kecamatan,
      required this.total_desa_kel});

  factory StatistikProgress.fromJson(Map<String, dynamic> json) {
    return StatistikProgress(
      targetSuara: json['target_suara'] ?? 0,
      grandTotal: json['grand_total'] ?? 0,
      totalKonstituen: json['total_konstituen'] ?? 0,
      potensiTinggi: json['potensi_tinggi'] ?? 0,
      potensiSedang: json['potensi_sedang'] ?? 0,
      potensiRendah: json['potensi_rendah'] ?? 0,
      total_tps: json['total_tps'] ?? 0,
      total_tps_male: json['total_tps_male'] ?? 0,
      total_tps_female: json['total_tps_female'] ?? 0,
      total_kab_kota: json['total_kab_kota'] ?? 0,
      total_kecamatan: json['total_kecamatan'] ?? 0,
      total_desa_kel: json['total_desa_kel'] ?? 0,
    );
  }
}

class WilayahData {
  final int noIndex;
  final String namaProvinsi;
  final String? namaKabupaten;
  final String? namaKecamatan;
  final String? namaKelurahan;
  final int tinggi;
  final int sedang;
  final int rendah;
  final int total;
  final DateTime updatedAt;

  WilayahData({
    required this.noIndex,
    required this.namaProvinsi,
    this.namaKabupaten,
    this.namaKecamatan,
    this.namaKelurahan,
    required this.tinggi,
    required this.sedang,
    required this.rendah,
    required this.total,
    required this.updatedAt,
  });

  factory WilayahData.fromJson(Map<String, dynamic> json) {
    return WilayahData(
      noIndex: json['no_index'],
      namaProvinsi: json['nama_provinsi'],
      namaKabupaten: json['nama_kabupaten'],
      namaKecamatan: json['nama_kecamatan'],
      namaKelurahan: json['nama_kelurahan'],
      tinggi: json['tinggi'],
      sedang: json['sedang'],
      rendah: json['rendah'],
      total: json['total'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class WilayahProgres {
  WilayahProgres({required this.x, required this.y, required this.text});
  dynamic x;
  dynamic y;
  dynamic text;
}
