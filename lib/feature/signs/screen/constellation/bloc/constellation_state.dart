part of 'constellation_bloc.dart';

class ConstellationState extends Equatable {
  const ConstellationState({
    this.zodiacs = const [],
    this.selectedZodiacIndex = 0,
    this.avatarUnLocked = 'No',
  });

  final List<Zodiac> zodiacs;
  final int selectedZodiacIndex;
  final String avatarUnLocked;

  @override
  List<Object> get props => [zodiacs, selectedZodiacIndex, avatarUnLocked];

  ConstellationState copyWith({
    List<Zodiac>? zodiacs,
    int? selectedZodiacIndex,
    String? avatarUnLocked,
  }) {
    return ConstellationState(
      zodiacs: zodiacs ?? this.zodiacs,
      selectedZodiacIndex: selectedZodiacIndex ?? this.selectedZodiacIndex,
      avatarUnLocked: avatarUnLocked ?? this.avatarUnLocked,
    );
  }
}
