class Profesi {
  final int id;
  final String name;

  Profesi({
    required this.id,
    required this.name,
  });

  factory Profesi.fromJson(Map<String, dynamic> json) {
    return Profesi(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
