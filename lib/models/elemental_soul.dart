class ElementalSoul {
  const ElementalSoul({
    required this.id,
    required this.question,
    required this.option,
  });
  final int id;
  final String question;
  final List<Option> option;

  factory ElementalSoul.fromJson(Map<String, dynamic> json) {
    return ElementalSoul(
      id: json['id'],
      question: json['question'],
      option:
          (json['option'] as List)
              .map((option) => Option.fromJson(option))
              .toList(),
    );
  }

  @override
  String toString() {
    return 'ElementalSoul(id: $id, question: $question, option: $option)';
  }
}

class Option {
  const Option({required this.text, required this.choice, required this.score});
  final String text;
  final String choice;
  final int score;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['text'],
      choice: json['choice'],
      score: json['score'],
    );
  }

  @override
  String toString() {
    return 'Option(text: $text, choice: $choice, score: $score)';
  }
}
