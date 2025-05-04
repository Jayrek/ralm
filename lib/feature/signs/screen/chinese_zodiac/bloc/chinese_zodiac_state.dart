part of 'chinese_zodiac_bloc.dart';

class ChineseZodiacState extends Equatable {
  const ChineseZodiacState({
    this.zodiacs = const [],
    this.selectedZodiacIndex = 0,
    this.avatarUnLocked = 'No',
    this.zodiacValue = '',
  });

  final List<ChineseZodiac> zodiacs;
  final int selectedZodiacIndex;
  final String avatarUnLocked;
  final String zodiacValue;

  @override
  List<Object> get props => [
    zodiacs,
    selectedZodiacIndex,
    avatarUnLocked,
    zodiacValue,
  ];

  ChineseZodiacState copyWith({
    final List<ChineseZodiac>? zodiacs,
    int? selectedZodiacIndex,
    String? avatarUnLocked,
    String? zodiacValue,
  }) {
    return ChineseZodiacState(
      zodiacs: zodiacs ?? this.zodiacs,
      selectedZodiacIndex: selectedZodiacIndex ?? this.selectedZodiacIndex,
      avatarUnLocked: avatarUnLocked ?? this.avatarUnLocked,
      zodiacValue: zodiacValue ?? this.zodiacValue,
    );
  }
}
