class Zodiac {
  const Zodiac({required this.id, required this.name, required this.dateRange});

  final int id;
  final String name;
  final String dateRange;

  factory Zodiac.fromJson(Map<String, dynamic> json) {
    return Zodiac(
      id: json['id'],
      name: json['name'],
      dateRange: json['date_range'],
    );
  }

  @override
  String toString() {
    return 'Zodiac(id: $id, name: $name, dateRange: $dateRange)';
  }
}
