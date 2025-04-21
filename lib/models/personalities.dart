class Personalities {
  const Personalities({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.aka,
    required this.akaDescription,
    required this.information,
    required this.strength,
    required this.weakness,
    required this.career,
  });

  final int id;
  final String name;
  final String description;
  final List<String> type;
  final String aka;
  final String akaDescription;
  final String information;
  final List<String> strength;
  final List<String> weakness;
  final List<String> career;

  factory Personalities.fromJson(Map<String, dynamic> json) {
    return Personalities(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: List<String>.from(json['type']),
      aka: json['aka'],
      akaDescription: json['aka_description'],
      information: json['information'],
      strength: List<String>.from(json['strength']),
      weakness: List<String>.from(json['weakness']),
      career: List<String>.from(json['career']),
    );
  }

  Personalities copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? type,
    String? aka,
    String? akaDescription,
    String? information,
    List<String>? strength,
    List<String>? weakness,
    List<String>? career,
  }) {
    return Personalities(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      aka: aka ?? this.aka,
      akaDescription: akaDescription ?? this.akaDescription,
      information: information ?? this.information,
      strength: strength ?? this.strength,
      weakness: weakness ?? this.weakness,
      career: career ?? this.career,
    );
  }

  @override
  String toString() {
    return 'Personalities(id: $id, name: $name, description: $description, type: $type, aka: $aka, akaDescription: $akaDescription, information: $information, strength: $strength, weakness: $weakness, career: $career)';
  }
}
