class ChineseZodiac {
  const ChineseZodiac({
    required this.id,
    required this.name,
    required this.years,
    required this.chineseZodiacData,
  });

  final int id;
  final String name;
  final List<int> years;
  final ChineseZodiacData chineseZodiacData;

  factory ChineseZodiac.fromJson(Map<String, dynamic> json) {
    return ChineseZodiac(
      id: json['id'],
      name: json['name'],
      years: List<int>.from(json['years']),
      chineseZodiacData: ChineseZodiacData.fromJson(json['data']),
    );
  }

  static final defaultValue = const ChineseZodiac(
    id: 0,
    name: '',
    years: [],
    chineseZodiacData: ChineseZodiacData(
      description: '',
      bestTraits: '',
      luckyNumber: '',
      luckyColor: '',
      bestPartners: '',
      badCompatible: '',
    ),
  );

  @override
  String toString() {
    return 'ChineseZodiac(id: $id, name: $name, years: $years, data: $chineseZodiacData)';
  }
}

class ChineseZodiacData {
  const ChineseZodiacData({
    required this.description,
    required this.bestTraits,
    required this.luckyNumber,
    required this.luckyColor,
    required this.bestPartners,
    required this.badCompatible,
  });
  final String description;
  final String bestTraits;
  final String luckyNumber;
  final String luckyColor;
  final String bestPartners;
  final String badCompatible;

  factory ChineseZodiacData.fromJson(Map<String, dynamic> json) {
    return ChineseZodiacData(
      description: json['description'],
      bestTraits: json['best_traits'],
      luckyNumber: json['lucky_number'],
      luckyColor: json['lucky_color'],
      bestPartners: json['best_partners'],
      badCompatible: json['bad_compatible'],
    );
  }

  @override
  String toString() {
    return 'ChineseZodiacData(description: $description, bestTraits: $bestTraits, luckyNumber: $luckyNumber, luckyColor: $luckyColor, bestPartners: $bestPartners, badCompatible: $badCompatible)';
  }
}
