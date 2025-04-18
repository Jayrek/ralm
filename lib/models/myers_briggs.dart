class MyersBriggs {
  const MyersBriggs({
    required this.id,
    required this.question,
    required this.myersBriggsOption,
    required this.selectedOption,
  });
  final int id;
  final String question;
  final List<MyersBriggsOption> myersBriggsOption;
  final MyersBriggsOption? selectedOption;

  factory MyersBriggs.fromJson(Map<String, dynamic> json) {
    return MyersBriggs(
      id: json['id'],
      question: json['question'],
      myersBriggsOption:
          (json['option'] as List)
              .map((option) => MyersBriggsOption.fromJson(option))
              .toList(),
      selectedOption:
          json['selected_option'] != null
              ? MyersBriggsOption.fromJson(json['selected_option'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'option': myersBriggsOption,
      'selected_option': selectedOption,
    };
  }

  MyersBriggs copyWith({
    int? id,
    String? question,
    List<MyersBriggsOption>? myersBriggsOption,
    MyersBriggsOption? selectedOption,
  }) {
    return MyersBriggs(
      id: id ?? this.id,
      question: question ?? this.question,
      myersBriggsOption: myersBriggsOption ?? this.myersBriggsOption,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  @override
  String toString() {
    return 'MyersBriggs(id: $id, question: $question, myersBriggsOption: $myersBriggsOption, selectedOption: $selectedOption)';
  }
}

class MyersBriggsOption {
  const MyersBriggsOption({
    required this.text,
    required this.personality,
    required this.personalityCode,
  });
  final String text;
  final String personality;
  final String personalityCode;

  factory MyersBriggsOption.fromJson(Map<String, dynamic> json) {
    return MyersBriggsOption(
      text: json['text'],
      personality: json['personality'],
      personalityCode: json['personality_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'personality': personality,
      'personality_code': personalityCode,
    };
  }

  MyersBriggsOption copyWith({
    String? text,
    String? personality,
    String? personalityCode,
  }) {
    return MyersBriggsOption(
      text: text ?? this.text,
      personality: personality ?? this.personality,
      personalityCode: personalityCode ?? this.personalityCode,
    );
  }

  @override
  String toString() {
    return 'MyersBriggsOption(text: $text, personality: $personality, personalityCode: $personalityCode)';
  }
}
