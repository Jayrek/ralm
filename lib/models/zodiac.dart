class Zodiac {
  const Zodiac({
    required this.id,
    required this.name,
    required this.dateRange,
    required this.data,
  });

  final int id;
  final String name;
  final String dateRange;
  final ConstellationZodiacData data;

  factory Zodiac.fromJson(Map<String, dynamic> json) {
    return Zodiac(
      id: json['id'],
      name: json['name'],
      dateRange: json['date_range'],
      data: ConstellationZodiacData.fromJson(json['data']),
    );
  }

  @override
  String toString() {
    return 'Zodiac(id: $id, name: $name, dateRange: $dateRange, data: $data)';
  }
}

class ConstellationZodiacData {
  const ConstellationZodiacData({
    required this.description,
    required this.bestTraits,
    required this.symbolized,
  });

  final String description;
  final String bestTraits;
  final String symbolized;

  factory ConstellationZodiacData.fromJson(Map<String, dynamic> json) {
    return ConstellationZodiacData(
      description: json['description'],
      bestTraits: json['best_traits'],
      symbolized: json['symbolized'],
    );
  }

  @override
  String toString() {
    return 'ConstellationZodiacData(description: $description, bestTraits: $bestTraits, symbolized: $symbolized)';
  }
}
