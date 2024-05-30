class Campaign {
  dynamic id;
  dynamic idCakada;
  dynamic name;
  dynamic date;
  dynamic clock;
  dynamic namaProvinsi;
  dynamic namaKabupaten;
  dynamic namaKecamatan;
  dynamic namaKelurahan;
  dynamic address;
  dynamic budget;

  dynamic description;

  Campaign({
    this.id,
    this.idCakada,
    this.name,
    this.date,
    this.clock,
    this.namaProvinsi,
    this.namaKabupaten,
    this.namaKecamatan,
    this.namaKelurahan,
    this.address,
    this.budget,
    this.description,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      idCakada: json['id_cakada'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      clock: json['clock'],
      namaProvinsi: json['nama_provinsi'],
      namaKabupaten: json['nama_kabupaten'],
      namaKecamatan: json['nama_kecamatan'],
      namaKelurahan: json['nama_kelurahan'],
      address: json['address'],
      budget: json['budget'],
      description: json['description'],
    );
  }
}
