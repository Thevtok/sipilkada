// ignore_for_file: non_constant_identifier_names

class Demografi {
  dynamic targetSuara;
  dynamic grandTotal;
  dynamic totalKonstituen;

  dynamic potensiTinggi;
  dynamic potensiSedang;
  dynamic potensiRendah;
  dynamic total_tps;
  dynamic total_tps_male;
  dynamic total_tps_female;
  dynamic total_kab_kota;
  dynamic total_kecamatan;
  dynamic total_desa_kel;
  dynamic total_konstituen_male;
  dynamic total_konstituen_female;
  dynamic total_konstituen_tuna_daksa;
  dynamic total_konstituen_tuna_netra;
  dynamic total_konstituen_tuna_rungu;
  dynamic total_konstituen_tuna_grahita;
  dynamic total_konstituen_tuna_lainnya;
  dynamic total_konstituen_difabel;
  dynamic total_konstituen_usia_17_30;
  dynamic total_konstituen_usia_31_40;
  dynamic total_konstituen_usia_41_50;
  dynamic total_konstituen_usia_51_60;
  dynamic total_konstituen_usia_lebih_60;

  Demografi({
    this.targetSuara,
    this.grandTotal,
    this.totalKonstituen,
    this.potensiTinggi,
    this.potensiSedang,
    this.potensiRendah,
    this.total_tps,
    this.total_tps_male,
    this.total_tps_female,
    this.total_kab_kota,
    this.total_kecamatan,
    this.total_desa_kel,
    this.total_konstituen_male,
    this.total_konstituen_female,
    this.total_konstituen_tuna_daksa,
    this.total_konstituen_tuna_netra,
    this.total_konstituen_tuna_rungu,
    this.total_konstituen_tuna_grahita,
    this.total_konstituen_tuna_lainnya,
    this.total_konstituen_difabel,
    this.total_konstituen_usia_17_30,
    this.total_konstituen_usia_31_40,
    this.total_konstituen_usia_41_50,
    this.total_konstituen_usia_51_60,
    this.total_konstituen_usia_lebih_60,
  });

  factory Demografi.fromJson(Map<String, dynamic> json) {
    return Demografi(
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
      total_konstituen_male: json['total_konstituen_male'],
      total_konstituen_female: json['total_konstituen_female'],
      total_konstituen_tuna_daksa: json['total_konstituen_tuna_daksa'],
      total_konstituen_tuna_netra: json['total_konstituen_tuna_netra'],
      total_konstituen_tuna_rungu: json['total_konstituen_tuna_rungu'],
      total_konstituen_tuna_grahita: json['total_konstituen_tuna_grahita'],
      total_konstituen_tuna_lainnya: json['total_konstituen_tuna_lainnya'],
      total_konstituen_difabel: json['total_konstituen_difabel'],
      total_konstituen_usia_17_30: json['total_konstituen_usia_17_30'],
      total_konstituen_usia_31_40: json['total_konstituen_usia_31_40'],
      total_konstituen_usia_41_50: json['total_konstituen_usia_41_50'],
      total_konstituen_usia_51_60: json['total_konstituen_usia_51_60'],
      total_konstituen_usia_lebih_60: json['total_konstituen_usia_lebih_60'],
    );
  }
}


class Gender {
  Gender({required this.x, required this.y, required this.text});
  dynamic x;
  dynamic y;
  dynamic text;
}

class Difabel {
  Difabel({required this.x, required this.y, required this.text});
  dynamic x;
  dynamic y;
  dynamic text;
}
class Usia {
  Usia({required this.x, required this.y, required this.text});
  dynamic x;
  dynamic y;
  dynamic text;
}