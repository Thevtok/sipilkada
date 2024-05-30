class DifabelList {
  final int id;
  final String name;

  DifabelList({
    required this.id,
    required this.name,
  });

  factory DifabelList.fromJson(Map<String, dynamic> json) {
    return DifabelList(
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
