part of 'chinese_zodiac_bloc.dart';

class ChineseZodiacState extends Equatable {
  const ChineseZodiacState({
    this.zodiacs = const [],
    this.selectedZodiacIndex = 0,
    this.avatarUnLocked = 'No',
  });

  final List<ChineseZodiac> zodiacs;
  final int selectedZodiacIndex;
  final String avatarUnLocked;

  @override
  List<Object> get props => [zodiacs, selectedZodiacIndex, avatarUnLocked];

  ChineseZodiacState copyWith({
    final List<ChineseZodiac>? zodiacs,
    int? selectedZodiacIndex,
    String? avatarUnLocked,
  }) {
    return ChineseZodiacState(
      zodiacs: zodiacs ?? this.zodiacs,
      selectedZodiacIndex: selectedZodiacIndex ?? this.selectedZodiacIndex,
      avatarUnLocked: avatarUnLocked ?? this.avatarUnLocked,
    );
  }
}
