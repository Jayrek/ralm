part of 'chinese_zodiac_bloc.dart';

class ChineseZodiacState extends Equatable {
  const ChineseZodiacState({
    this.zodiacs = const [],
    this.selectedZodiacIndex = 0,
  });

  final List<ChineseZodiac> zodiacs;
  final int selectedZodiacIndex;

  @override
  List<Object> get props => [zodiacs, selectedZodiacIndex];

  ChineseZodiacState copyWith({
    final List<ChineseZodiac>? zodiacs,
    int? selectedZodiacIndex,
  }) {
    return ChineseZodiacState(
      zodiacs: zodiacs ?? this.zodiacs,
      selectedZodiacIndex: selectedZodiacIndex ?? this.selectedZodiacIndex,
    );
  }
}
