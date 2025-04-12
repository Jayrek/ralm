part of 'elemental_soul_bloc.dart';

class ElementalSoulState extends Equatable {
  const ElementalSoulState({
    this.elementalSoulQuestions = const [],
    this.currentIndex = 0,
    this.totalScore = 0,
    this.elementalSoulResult = '',
  });

  final List<ElementalSoul> elementalSoulQuestions;
  final int currentIndex;
  final int totalScore;
  final String elementalSoulResult;

  @override
  List<Object> get props => [
    elementalSoulQuestions,
    currentIndex,
    totalScore,
    elementalSoulResult,
  ];

  ElementalSoulState copyWith({
    List<ElementalSoul>? elementalSoulQuestions,
    int? currentIndex,
    int? totalScore,
    String? elementalSoulResult,
  }) {
    return ElementalSoulState(
      elementalSoulQuestions:
          elementalSoulQuestions ?? this.elementalSoulQuestions,
      currentIndex: currentIndex ?? this.currentIndex,
      totalScore: totalScore ?? this.totalScore,
      elementalSoulResult: elementalSoulResult ?? this.elementalSoulResult,
    );
  }
}
