class Pendidikan {
  final int id;
  final String name;

  Pendidikan({
    required this.id,
    required this.name,
  });

  factory Pendidikan.fromJson(Map<String, dynamic> json) {
    return Pendidikan(
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
