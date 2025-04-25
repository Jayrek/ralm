part of 'your_color_bloc.dart';

class YourColorState extends Equatable {
  const YourColorState({
    this.yourColorQuestions = const [],
    this.currentIndex = 0,
    this.totalScore = 0,
    this.yourColorResult = '',
    this.avatarUnLocked = 'No',
  });

  final List<ElementalSoul> yourColorQuestions;
  final int currentIndex;
  final int totalScore;
  final String yourColorResult;
  final String avatarUnLocked;

  @override
  List<Object> get props => [
    yourColorQuestions,
    currentIndex,
    totalScore,
    yourColorResult,
    avatarUnLocked,
  ];

  YourColorState copyWith({
    List<ElementalSoul>? yourColorQuestions,
    int? currentIndex,
    int? totalScore,
    String? yourColorResult,
    String? avatarUnLocked,
  }) {
    return YourColorState(
      yourColorQuestions: yourColorQuestions ?? this.yourColorQuestions,
      currentIndex: currentIndex ?? this.currentIndex,
      totalScore: totalScore ?? this.totalScore,
      yourColorResult: yourColorResult ?? this.yourColorResult,
      avatarUnLocked: avatarUnLocked ?? this.avatarUnLocked,
    );
  }
}
