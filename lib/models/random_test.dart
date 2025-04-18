class RandomTest {
  const RandomTest({
    required this.id,
    required this.question,
    required this.image,
    required this.results,
  });
  final int id;
  final String question;
  final String image;
  final String results;

  factory RandomTest.fromJson(Map<String, dynamic> json) {
    return RandomTest(
      id: json['id'],
      question: json['question'],
      image: json['image'],
      results: json['results'],
    );
  }

  RandomTest copyWith({
    int? id,
    String? question,
    String? image,
    String? results,
  }) {
    return RandomTest(
      id: id ?? this.id,
      question: question ?? this.question,
      image: image ?? this.image,
      results: results ?? this.results,
    );
  }

  @override
  String toString() {
    return 'RandomTest(id: $id, question: $question, image: $image, results: $results)';
  }
}
