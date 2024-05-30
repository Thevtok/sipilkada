// ignore_for_file: file_names

class Provinsi {
  final int id;
  final String name;

  Provinsi(this.id, this.name);

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(
      json['id'] as int,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Kabupaten {
  final int id;
  final int provinsiId;
  final String name;

  Kabupaten(this.id, this.provinsiId, this.name);

  factory Kabupaten.fromJson(Map<String, dynamic> json) {
    return Kabupaten(
      json['id'] as int,
      json['id_provinsi'] as int,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_provinsi': provinsiId,
      'name': name,
    };
  }
}

class Kecamatan {
  final int id;

  final String name;

  Kecamatan(this.id, this.name);

  factory Kecamatan.fromJson(Map<String, dynamic> json) {
    return Kecamatan(
      json['id'] as int,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class Kelurahan {
  final int id;

  final String name;

  Kelurahan(this.id, this.name);

  factory Kelurahan.fromJson(Map<String, dynamic> json) {
    return Kelurahan(
      json['id'] as int,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
