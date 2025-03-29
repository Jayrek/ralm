class ChineseZodiac {
  const ChineseZodiac({
    required this.id,
    required this.name,
    required this.years,
  });

  final int id;
  final String name;
  final List<int> years;

  factory ChineseZodiac.fromJson(Map<String, dynamic> json) {
    return ChineseZodiac(
      id: json['id'],
      name: json['name'],
      years: List<int>.from(json['years']),
    );
  }

  @override
  String toString() {
    return 'ChineseZodiac(id: $id, name: $name, years: $years)';
  }
}
