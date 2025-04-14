class ForestTest {
  const ForestTest({required this.id, required this.forestTestData});
  final int id;
  final ForestTestData forestTestData;

  factory ForestTest.fromJson(Map<String, dynamic> json) {
    return ForestTest(
      id: json['id'],
      forestTestData: ForestTestData.fromJson(json['data']),
    );
  }

  ForestTest copyWith({int? id, ForestTestData? forestTestData}) {
    return ForestTest(
      id: id ?? this.id,
      forestTestData: forestTestData ?? this.forestTestData,
    );
  }

  @override
  String toString() {
    return 'ForestTest(id: $id, data: $forestTestData)';
  }
}

class ForestTestData {
  const ForestTestData({required this.description});
  final String description;

  factory ForestTestData.fromJson(Map<String, dynamic> json) {
    return ForestTestData(description: json['description']);
  }

  ForestTestData copyWith({String? description}) {
    return ForestTestData(description: description ?? this.description);
  }

  @override
  String toString() {
    return 'ForestTestData(description: $description)';
  }
}
