part of 'your_color_bloc.dart';

class YourColorState extends Equatable {
  const YourColorState({
    this.yourColorQuestions = const [],
    this.currentIndex = 0,
    this.totalScore = 0,
    this.yourColorResult = '',
  });

  final List<ElementalSoul> yourColorQuestions;
  final int currentIndex;
  final int totalScore;
  final String yourColorResult;

  @override
  List<Object> get props => [
    yourColorQuestions,
    currentIndex,
    totalScore,
    yourColorResult,
  ];

  YourColorState copyWith({
    List<ElementalSoul>? yourColorQuestions,
    int? currentIndex,
    int? totalScore,
    String? yourColorResult,
  }) {
    return YourColorState(
      yourColorQuestions: yourColorQuestions ?? this.yourColorQuestions,
      currentIndex: currentIndex ?? this.currentIndex,
      totalScore: totalScore ?? this.totalScore,
      yourColorResult: yourColorResult ?? this.yourColorResult,
    );
  }
}
