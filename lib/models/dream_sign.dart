class DreamSign {
  const DreamSign({
    required this.id,
    required this.title,
    required this.information,
  });
  final int id;
  final String title;
  final String information;

  factory DreamSign.fromJson(Map<String, dynamic> json) {
    return DreamSign(
      id: json['id'],
      title: json['title'],
      information: json['information'],
    );
  }

  DreamSign copyWith({int? id, String? title, String? information}) {
    return DreamSign(
      id: id ?? this.id,
      title: title ?? this.title,
      information: information ?? this.information,
    );
  }

  @override
  String toString() {
    return 'DreamSign(id: $id, title: $title, information: $information)';
  }
}
