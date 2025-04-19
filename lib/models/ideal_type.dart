class IdealType {
  const IdealType({
    required this.id,
    required this.question,
    required this.choices,
  });
  final int id;
  final String question;
  final List<IdealTypeChoices> choices;

  factory IdealType.fromJson(Map<String, dynamic> json) {
    return IdealType(
      id: json['id'],
      question: json['question'],
      choices:
          (json['choices'] as List)
              .map((type) => IdealTypeChoices.fromJson(type))
              .toList(),
    );
  }

  IdealType copyWith({
    int? id,
    String? question,
    List<IdealTypeChoices>? choices,
  }) {
    return IdealType(
      id: id ?? this.id,
      question: question ?? this.question,
      choices: choices ?? this.choices,
    );
  }

  @override
  String toString() {
    return 'IdealType(id: $id, question: $question, choices: $choices)';
  }
}

class IdealTypeChoices {
  const IdealTypeChoices({required this.points, required this.image});
  final int points;
  final String image;

  factory IdealTypeChoices.fromJson(Map<String, dynamic> json) {
    return IdealTypeChoices(points: json['points'], image: json['image']);
  }

  IdealTypeChoices copyWith({int? points, String? image}) {
    return IdealTypeChoices(
      points: points ?? this.points,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'IdealTypeChoices(points: $points, image: $image)';
  }
}
