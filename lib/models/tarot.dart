class Tarot {
  const Tarot({
    required this.id,
    required this.cardName,
    required this.description,
    required this.image,
  });
  final int id;
  final String cardName;
  final String description;
  final String image;

  factory Tarot.fromJson(Map<String, dynamic> json) {
    return Tarot(
      id: json['id'],
      cardName: json['card_name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Tarot copyWith({
    int? id,
    String? cardName,
    String? description,
    String? image,
  }) {
    return Tarot(
      id: id ?? this.id,
      cardName: cardName ?? this.cardName,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'Tarot(id: $id, cardName: $cardName, description: $description, image: $image)';
  }
}
